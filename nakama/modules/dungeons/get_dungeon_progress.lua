local nk = require("nakama")
local models = require("models")
local tables = require("tables")


function get_dungeon_progress(_context)
    local dt = os.date("*t")
    local current_time_in_sec = os.time{year=dt.year, month=dt.month, day=dt.day, hour = dt.hour, min=dt.min, sec=dt.sec}

    local read_dungeon_progress_storage_object = models.get_read_storage_model()
    read_dungeon_progress_storage_object.collection = tables.dungeon_progress
    read_dungeon_progress_storage_object.user_id = _context.user_id

    local success, objects = pcall(nk.storage_list, _context.user_id, tables.dungeon_progress, 100)

    if (not success) then
        nk.logger_error(string.format("list storage error: %q", objects))
        error({ "internal server error", 13 })
    end
    
    local result = {}

    local idx = 1
    for _, object in pairs(objects) do
        local dungeon_data = get_dungeon_data(object.key)
        local dp = object.value
        
        local r = {
            progress = nil,
            finished = nil,
            duration = nil,
            type = nil
        }
        
        r.duration = dungeon_data.duration
        r.type = object.key

        if (current_time_in_sec - dungeon_data.duration > dp.start_time) then
            r.finished = true
            r.progress = 100
        else
            r.finished = false
            local time_elapsed = current_time_in_sec - dp.start_time
            r.progress = (time_elapsed / dungeon_data.duration) * 100
        end

        result[idx] = r
        idx = idx + 1
    end

    return nk.json_encode(result)
end

nk.register_rpc(get_dungeon_progress, "get_dungeon_progress")

function get_dungeon_data(key)
    local read_dungeon_storage_object = models.get_read_storage_model()
    read_dungeon_storage_object.collection = tables.dungeons
    read_dungeon_storage_object.key = key

    local success, objects = pcall(nk.storage_read, {read_dungeon_storage_object})

    if (not success) then
        nk.logger_error(string.format("storage_write error: %q", result))
        error({ "internal server error", 13 })
    end

    return objects[1].value
end