--[[
-- added by wsh @ 2017-12-01
-- UILogin��ͼ��
-- ע�⣺
-- 1����Ա�������Ԥ����__init������������ߴ���ɶ���
-- 2��OnEnable����ÿ���ڴ��ڴ�ʱ���ã�ֱ��ˢ��
-- 3����������ο�����淶
--]]


local UILoginViewModel = BaseClass("UILoginViewModel")
local UILoginItemViewModel = require "UI.UILogin.ViewModel.UILoginItemViewModel"

local function OnCreate(self)

    self.Name = BindableProperty.New("Justin..")
    self.Age = BindableProperty.New(0)


    Items = BindableProperty.New({})

    self.testList = BindableProperty.New({})
    local tmplist = {}
    for i = 1, 10 do
        local it = UILoginItemViewModel.New()
        it:OnCreate(i + 1000)

        table.insert(tmplist, it)
    end
    --self.testList.Value = tmplist


    self.List = ObservableList.New();
    self.List.Value = tmplist


    self.Content = ComputeBindableProperty.New({ self.Name, self.Age}, function(Name, Age)
        print(Name .. Age.." justin.......................")
        return Name .. Age.." justin......................."
    end)

end

local function UpdateData(self,name)
    --self.Name.Value = "Justin....modify......"
    --self.Age.Value = 99;
    print("==================Update Jjjjj")
    local it = UILoginItemViewModel.New()
    it:OnCreate(999)
    self.List:Add(it)

    self.Name.Value = "Baby...Tell me..."..name

end

UILoginViewModel.OnCreate = OnCreate
UILoginViewModel.UpdateData = UpdateData


return UILoginViewModel