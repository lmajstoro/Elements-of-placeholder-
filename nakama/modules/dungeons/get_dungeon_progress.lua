local nk = require("nakama")
local models = require("models")
local tables = require("tables")


function get_dungeon_progress(_context, payload)
    local json = nk.json_decode(payload)
    nk.logger_info(json.key)

    local dt = os.date("*t")
    local current_time_in_sec = os.time{year=dt.year, month=dt.month, day=dt.day, hour = dt.hour, min=dt.min, sec=dt.sec}
    
    local read_dungeon_storage_object = models.get_read_storage_model()
    read_dungeon_storage_object.collection = tables.dungeons
    read_dungeon_storage_object.key = json.key

    local success, objects = pcall(nk.storage_read, {read_dungeon_storage_object})

    if (not success) then
        nk.logger_error(string.format("storage_write error: %q", result))
        error({ "internal server error", 13 })
    end

    local dungeon_data = objects[1].value

    local read_dungeon_progress_storage_object = models.get_read_storage_model()
    read_dungeon_progress_storage_object.collection = tables.dungeon_progress
    read_dungeon_progress_storage_object.key = json.key
    read_dungeon_progress_storage_object.user_id = _context.user_id

    local success, objects = pcall(nk.storage_read, {read_dungeon_progress_storage_object})

    if (not success) then
        nk.logger_error(string.format("storage_write error: %q", objects))
        error({ "internal server error", 13 })
    end

    local dp = objects[1].value
    
    local r = {
        progress = nil,
        finished = nil,
    }

    if (current_time_in_sec - dungeon_data.duration > dp.start_time) then
        r.finished = true
        r.progress = 100
    else
        r.finished = false
        local time_elapsed = current_time_in_sec - dp.start_time
        r.progress = (time_elapsed / dungeon_data.duration) * 100
    end

    return nk.json_encode(r)
end

nk.register_rpc(get_dungeon_progress, "get_dungeon_progress")