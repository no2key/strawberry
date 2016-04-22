-- perf
local error = error
local ngxmatch=ngx.re.gmatch

-- init Simple and set routes
local Simple = {}

function Simple:new()
    local instance = {
        route_name = 'framework.routes.simple',
    }

    setmetatable(instance, {
        __index = self,
        __tostring = function(self) return self.route_name end
        })
    return instance
end

function Simple:set_request(request)
    self.request = request
end

function Simple:match()
    local uri = self.request.uri
    local match = {}
    local tmp = 1
    if uri == '/' then
        return 'index', 'index'
    end
    for v in ngxmatch(uri , '/([A-Za-z0-9_]+)') do
        match[tmp] = v[1]
        tmp = tmp +1
    end
    if #match == 1 then
        return match[1], 'index'
    else
        return table.concat(match, '.', 1, #match - 1), match[#match]
    end
end

return Simple
