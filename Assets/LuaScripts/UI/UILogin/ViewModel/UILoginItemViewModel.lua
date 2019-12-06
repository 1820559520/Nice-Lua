--[[
-- added by wsh @ 2017-12-01
-- UILogin��ͼ��
-- ע�⣺
-- 1����Ա�������Ԥ����__init������������ߴ���ɶ���
-- 2��OnEnable����ÿ���ڴ��ڴ�ʱ���ã�ֱ��ˢ��
-- 3����������ο�����淶
--]]


local UILoginItemViewModel = BaseClass("UILoginItemViewModel",UIBaseViewModel)


local function OnCreate(self,age)

    self.Name = BindableProperty.New("Jim..")
    self.Age = BindableProperty.New(age)

end

local function UpdateData(self, data)
    self.Name.Value = data.Name
    self.Age.Value = data.Age

end

UILoginItemViewModel.OnCreate = OnCreate
UILoginItemViewModel.UpdateData = UpdateData


return UILoginItemViewModel