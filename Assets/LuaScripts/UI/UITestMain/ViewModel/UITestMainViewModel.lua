--[[
-- added by wsh @ 2017-12-01
-- UILogin��ͼ��
-- ע�⣺
-- 1����Ա�������Ԥ����__init������������ߴ���ɶ���
-- 2��OnEnable����ÿ���ڴ��ڴ�ʱ���ã�ֱ��ˢ��
-- 3����������ο�����淶
--]]


local UITestMainViewModel = BaseClass("UITestMainViewModel",UIBaseViewModel)

local function OnCreate(self)
    self.hp_text = BindableProperty.New()
    self.mp_text = BindableProperty.New()
    self.money_text = BindableProperty.New()


end

local function UpdateData(self,data)
    if(data.hp_text) then self.hp_text.Value = data.hp_text end
    if(data.mp_text) then self.mp_text.Value = data.mp_text end
    if(data.money_text) then self.money_text.Value = data.money_text end

end

UITestMainViewModel.OnCreate = OnCreate
UITestMainViewModel.UpdateData = UpdateData


return UITestMainViewModel