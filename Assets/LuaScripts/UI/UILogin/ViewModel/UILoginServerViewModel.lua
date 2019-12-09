local UILoginServerViewModel = BaseClass("UILoginServerViewModel", UIBaseViewModel)
local base = UIBaseViewModel

local function OnCreate(self)

    self.selected_server_id = nil

    self.back_btn = {
        OnClick = function()
            UIManager:GetInstance():CloseWindow(UIWindowNames.UILoginServer)
        end
    }
    self.confirm_btn = {
        OnClick = function()
            -- �Ϸ���У��
            if self.selected_server_id == nil then
                -- TODO�����󵯴�
                Logger.LogError("svr_id nil")
                return
            end
            local servers = ServerData:GetInstance().servers
            if servers[self.selected_server_id] == nil then
                -- TODO�����󵯴�
                Logger.LogError("no svr_id : "..tostring(self.selected_server_id))
                return
            end

            ClientData:GetInstance():SetLoginServerID(self.selected_server_id)
            UIManager:GetInstance():CloseWindow(UIWindowNames.UILoginServer)
        end
    }


end

-- ��
local function OnEnable(self)
    base.OnEnable(self)
    -- ���ڹر�ʱ��������ĳ�Ա��������
    -- �Ƽ��������б�
    self.recommend_servers = nil
    -- ����id�б�
    self.area_ids = nil
    -- ���������µķ������б�
    self.area_servers = nil
    -- ��ǰѡ��ĵ�½������
    self.selected_server_id = 0

    self:OnRefresh()
end

-- ��ȡ�Ƽ��������б�
local function FetchRecommendList(servers)
    local recommend_servers = {}
    for _,v in pairs(servers) do
        if v.recommend then
            table.insert(recommend_servers, v)
        end
    end
    table.sort(recommend_servers, function(ltb, rtb)
        return ltb.server_id < rtb.server_id
    end
    )
    return recommend_servers
end

-- �����򻮷ַ������б�
local function FetchAreaList(servers)
    local area_ids_record = {}
    local area_ids = {}
    local area_servers = {}
    for _,v in pairs(servers) do
        local key = v.area_id
        local area = area_servers[key]
        if area == nil then
            area = {}
        end
        table.insert(area, v)
        area_servers[key] = area
        if area_ids_record[v.area_id] == nil then
            area_ids_record[v.area_id] = v.area_id
            table.insert(area_ids, v.area_id)
        end
    end
    table.sort(area_ids)
    for _,v in pairs(area_servers) do
        table.sort(v, function(ltb, rtb)
            return ltb.server_id < rtb.server_id
        end)
    end
    return area_ids, area_servers
end

local function OnRefresh(self)
    local server_data = ServerData:GetInstance()
    self.recommend_servers = FetchRecommendList(server_data.servers)
    self.area_ids, self.area_servers = FetchAreaList(server_data.servers)
    self.selected_server_id = ClientData:GetInstance().login_server_id

end

-- �ر�
local function OnDisable(self)
    base.OnDisable(self)
    -- �����Ա����
    self.recommend_servers = nil
    self.area_ids = nil
    self.area_servers = nil
    self.selected_server_id = 0
end

-- ����
local function OnDistroy(self)
    base.OnDistroy(self)
    -- �����Ա����
end


UILoginServerViewModel.OnEnable = OnEnable
UILoginServerViewModel.OnDisable = OnDisable
UILoginServerViewModel.OnCreate = OnCreate
UILoginServerViewModel.OnDistroy = OnDistroy
UILoginServerViewModel.OnRefresh = OnRefresh


return UILoginServerViewModel