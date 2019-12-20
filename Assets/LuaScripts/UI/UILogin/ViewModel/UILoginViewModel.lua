--[[
-- added by wsh @ 2017-12-01
-- UILogin��ͼ��
-- ע�⣺
-- 1����Ա�������Ԥ����__init������������ߴ���ɶ���
-- 2��OnEnable����ÿ���ڴ��ڴ�ʱ���ã�ֱ��ˢ��
-- 3����������ο�����淶
--]]

local UILoginViewModel = BaseClass("UILoginViewModel",UIBaseViewModel)
local base = UIBaseViewModel

local function OnCreate(self)
    self.app_version_text = BindableProperty.New("1.0.1")
    self.res_version_text = BindableProperty.New(8898)
    self.server_text = BindableProperty.New("")

    self.account_input = BindableProperty.New("Justinz")
    self.password_input = BindableProperty.New("123456")

    self.test_timer_text  = BindableProperty.New(0)
    self.test_coroutine_text  = BindableProperty.New(0)

    self.login_btn_click = {
        OnClick = function()
            -- �Ϸ��Լ���
            local name = self.account_input.Value
            local password = self.password_input.Value
            if string.len(name) > 20 or string.len(name) < 1 then
                -- TODO�����󵯴�
                Logger.LogError("name length err!")
                return;
            end
            if string.len(password) > 20 or string.len(password) < 1 then
                -- TODO�����󵯴�
                Logger.LogError("password length err!")
                return;
            end
            -- ����Ƿ��к���
            for i=1, string.len(name) do
                local curByte = string.byte(name, i)
                if curByte > 127 then
                    -- TODO�����󵯴�
                    Logger.LogError("name err : only ascii can be used!")
                    return;
                end;
            end

            ClientData:GetInstance():SetAccountInfo(name, password)

            -- TODO start socket
            --ConnectServer(self)
            NetManager:GetInstance():ConnectGameServer("127.0.0.1", 10002, self.OnGameServerConnected)
            --SceneManager:GetInstance():SwitchScene(SceneConfig.HomeScene)
        end
    }
    self.server_select_btn = {
        OnClick = function()
            UIManager:GetInstance():OpenWindow(UIWindowNames.UILoginServer)
        end
    }
    self.long_pass_btn = {
        OnClick = function()
            print("================================ slong_pass_btn click............................")
        end,
        OnPress = function()
            print("================================ slong_pass_btn OnPress............................")
        end
    }


    -- ����һ��Ҫ�Իص������������ã�������ʱ���ܱ�GC������ʱ��ʧЧ
    -- ����ʹ�ó�Ա�������������������ǺͶ������һ���
    do
        self.timer_action = function(self)
            self.test_timer_text.Value = self.test_timer_text.Value + 1
        end
        self.timer = TimerManager:GetInstance():GetTimer(1, self.timer_action , self)
        -- ������ʱ��
        self.timer:Start()
        -- ����Э��
        coroutine.start(function()
            -- ����Ĵ���������ڲ��ԣ���ģ�£������׳������⣺
            -- 1��ʱ��ͳ�����ۻ�����ʵЭ������UI����ʱչʾʱһ�����ⲻ�󣬵���ʱ����΢����ʵʱ�䳤������Ӱ�����鿼��
            -- 2�����Э��һ�������޷������գ���Ȼ�����Ա�����㣬ʹ��һ�����Ʊ������ڶ������ٵ�ʱ���˳���ѭ������
            while true do
                coroutine.waitforseconds(0.5)
                self.test_coroutine_text.Value = self.test_coroutine_text.Value + 0.5

            end
        end)
    end

    self:OnRefresh()


-- ��
    base.OnEnable(self)
end

local function OnLoginRsp(receiveMessage)
    NetManager:GetInstance():RemoveListener(MsgIDDefine.LOGIN_RSP_LOGIN, OnLoginRsp)

    Logger.Log(tostring(receiveMessage))
    print("receive message=====Login Success=============")
    print(receiveMessage.RequestSeq)
    print(receiveMessage.MsgId)

    SceneManager:GetInstance():SwitchScene(SceneConfig.HomeScene)
end

local function OnGameServerConnected(self)
    --��Ϸ�����ӳɹ�

    local c2r_login = {
        flag = 9981,
    }
    NetManager:GetInstance():SendGameMsg(MsgIDDefine.LOGIN_REQ_LOGIN, c2r_login, true, true)
    --�����Ϣ����
    NetManager:GetInstance():AddListener(MsgIDDefine.LOGIN_RSP_LOGIN, OnLoginRsp)
end



local function SetServerInfo(self, select_svr_id)
    local server_data = ServerData:GetInstance()
    local client_data = ClientData:GetInstance()

    local select_svr = server_data.servers[select_svr_id]

    if select_svr ~= nil then
        local area_name = LangUtil.GetServerAreaName(select_svr.area_id)
        local server_name = LangUtil.GetServerName(client_data.login_server_id)
        self.server_text.Value = area_name..server_name
    end
end

-- ˢ��ȫ������
local function OnRefresh(self)
    local client_data = ClientData:GetInstance()
    self.account_input.Value = client_data.account
    self.password_input.Value = client_data.password
    self.app_version_text.Value = client_data.app_version
    self.res_version_text.Value = client_data.res_version
    SetServerInfo(self, client_data.login_server_id)
end


local function OnSelectedSvrChg(self, id)
    SetServerInfo(self, id)
end

-- ����ѡ���䶯
local function OnAddListener(self)
    base.OnAddListener(self)
    self:AddDataListener(DataMessageNames.ON_LOGIN_SERVER_ID_CHG, OnSelectedSvrChg)
end

local function OnRemoveListener(self)
    base.OnRemoveListener(self)
    self:RemoveDataListener(DataMessageNames.ON_LOGIN_SERVER_ID_CHG, OnSelectedSvrChg)
end

-- �ر�
local function OnDisable(self)
    base.OnDisable(self)
    -- �����Ա����
end

-- ����
local function OnDistroy(self)
    base.OnDistroy(self)
    -- �����Ա����
end

UILoginViewModel.OnEnable = OnEnable
UILoginViewModel.OnDisable = OnDisable
UILoginViewModel.OnCreate = OnCreate
UILoginViewModel.OnDistroy = OnDistroy
UILoginViewModel.OnRefresh = OnRefresh
UILoginViewModel.OnAddListener = OnAddListener
UILoginViewModel.OnRemoveListener = OnRemoveListener
UILoginViewModel.on_connect = on_connect
UILoginViewModel.on_close = on_close
UILoginViewModel.OnGameServerConnected = OnGameServerConnected


return UILoginViewModel