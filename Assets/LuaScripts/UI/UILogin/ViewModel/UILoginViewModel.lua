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
    print("UILogin View Model OnCreate..................")
    self.account_input = BindableProperty.New("justin")
    self.password_input = BindableProperty.New()

end

local function UpdateData(self,name)

end

UILoginViewModel.OnCreate = OnCreate
UILoginViewModel.UpdateData = UpdateData


return UILoginViewModel