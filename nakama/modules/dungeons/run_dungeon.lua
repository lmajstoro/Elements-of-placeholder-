local nk = require("nakama")
local models = require("models")
local tables = require("tables")
 

function run_dungeon(_context, payload)
    local json = nk.json_decode(payload)
    nk.logger_info(string.format("Payload: %q", json))

    local dt = os.date("*t")    
    local current_time_in_sec = os.time{year=dt.year, month=dt.month, day=dt.day, hour = dt.hour, min=dt.min, sec=dt.sec}

    local dungeon_progress_model = models.get_dungeon_progress_model()
    dungeon_progress_model.start_time = current_time_in_sec

    local write_storage_model = models.get_write_storage_model()
    write_storage_model.collection = tables.dungeon_progress
    write_storage_model.value = dungeon_progress_model
    write_storage_model.key = json.key
    write_storage_model.user_id = _context.user_id

    local success, result = pcall(nk.storage_write, { write_storage_model })

    if (not success) then
        nk.logger_error(string.format("storage_write error: %q", result))
        error({ "internal server error", 13 })
    end

    return nk.json_encode(result)
end

nk.register_rpc(run_dungeon, "run_dungeon")