--[[
-- added by wsh @ 2017-12-01
-- UILogin��ͼ��
-- ע�⣺
-- 1����Ա�������Ԥ����__init������������ߴ���ɶ���
-- 2��OnEnable����ÿ���ڴ��ڴ�ʱ���ã�ֱ��ˢ��
-- 3����������ο�����淶
--]]


local UILoginViewModel = BaseClass("UILoginViewModel",UIBaseViewModel)

local function OnCreate(self)
    self.app_version_text = BindableProperty.New()
    self.res_version_text = BindableProperty.New()
    self.server_text = BindableProperty.New()

    self.account_input = BindableProperty.New()
    self.password_input = BindableProperty.New()

    self.login_btn_click = {
        OnClick = function()
            print("================================ login btn click............................")
        end
    }
end

local function UpdateData(self,data)
    if(data.app_version_text) then self.app_version_text.Value = data.app_version_text end
    if(data.res_version_text) then self.res_version_text.Value = data.res_version_text end
    if(data.server_text) then self.server_text.Value = data.server_text end
    if(data.account_input) then self.account_input.Value = data.account_input end
    if(data.password_input) then self.password_input.Value = data.password_input end
end

UILoginViewModel.OnCreate = OnCreate
UILoginViewModel.UpdateData = UpdateData


return UILoginViewModel