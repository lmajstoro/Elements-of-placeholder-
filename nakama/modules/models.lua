local M = {}

function M.get_dungeon_progress_model()
    return {
        start_time = nil
    }
end

function M.get_dungeon_model()

    return{
        duration = nil
    }

end

function M.get_read_storage_model()
    return {
        collection = nil,
        key = nil,
        user_id = nil
    }
end

function M.get_write_storage_model()
    return {
        collection = nil,
        key = nil,
        value = nil,
        user_id = nil,
        permission_read = 1,
        permission_write = 0
    }
end

return M