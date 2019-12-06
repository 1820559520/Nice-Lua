--[[

--]]

local UIBaseViewModel = BaseClass("UIBaseViewModel")

-- ��Ǳ�Ҫ������д���캯����ʹ��OnCreate��ʼ��
local function __init(self, ui_name)

    self.__ui_name = ui_name
    self:OnCreate()
end

-- ��Ǳ�Ҫ������д����������ʹ��OnDestroy������Դ
local function __delete(self)
    self:OnDestroy()

    self.__ui_name = nil
end

-- ����
-- ע�⣺��������OnCreate�������ı���
local function OnDestroy(self)
end

-- �������������壬��ʼ������Ϣע��
-- ע�⣺�������������ڱ��ֵĳ�Ա��������
local function OnCreate(self)
end

--��������
local function UpdateData(self, data)
end

UIBaseViewModel.__init = __init
UIBaseViewModel.__delete = __delete
UIBaseViewModel.OnDestroy = OnDestroy
UIBaseViewModel.OnCreate = OnCreate
UIBaseViewModel.UpdateData = UpdateData


return UIBaseViewModel