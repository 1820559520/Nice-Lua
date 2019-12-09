--[[

--]]

local UIBaseViewModel = BaseClass("UIBaseViewModel")

-- ��Ǳ�Ҫ������д���캯����ʹ��OnCreate��ʼ��
local function __init(self, ui_name)
    self.__data_callback = {}
    self.__ui_name = ui_name
    self:OnCreate()
end

-- ��Ǳ�Ҫ������д����������ʹ��OnDestroy������Դ
local function __delete(self)
    self:OnDestroy()
    for k,v in pairs(self.__data_callback) do
        self:RemoveDataListener(k, v)
    end
    self.__data_callback = nil
    self.__ui_name = nil
end

local function AddCallback(keeper, msg_name, callback)
    assert(callback ~= nil)
    keeper[msg_name] = callback
end

local function GetCallback(keeper, msg_name)
    return keeper[msg_name]
end

local function RemoveCallback(keeper, msg_name, callback)
    assert(callback ~= nil)
    keeper[msg_name] = nil
end

-- ע����Ϸ���ݼ����¼�������д
local function AddDataListener(self, msg_name, callback)
    local bindFunc = Bind(self, callback)
    AddCallback(self.__data_callback, msg_name, bindFunc)
    DataManager:GetInstance():AddListener(msg_name, bindFunc)
end

-- ע����Ϸ���ݼ����¼�������д
local function RemoveDataListener(self, msg_name, callback)
    local bindFunc = GetCallback(self.__data_callback, msg_name)
    RemoveCallback(self.__data_callback, msg_name, bindFunc)
    DataManager:GetInstance():RemoveListener(msg_name, bindFunc)
end

-- �������������壬��ʼ������Ϣע��
-- ע�⣺�������������ڱ��ֵĳ�Ա��������
local function OnCreate(self)
end

-- �򿪣�ˢ������ģ��
-- ע�⣺���ڹر�ʱ��������ĳ�Ա��������
local function OnEnable(self, ...)
end

-- �ر�
-- ע�⣺��������OnEnable�������ı���
local function OnDisable(self)
end

-- ����
-- ע�⣺��������OnCreate�������ı���
local function OnDestroy(self)
end

-- ע����Ϣ
local function OnAddListener(self)
end

-- ע����Ϣ
local function OnRemoveListener(self)
end

-- �����UIManager�ã�����д
local function Activate(self, ...)
    self:OnAddListener()
    self:OnEnable(...)
end

-- �������UIManager�ã�����д
local function Deactivate(self)
    self:OnRemoveListener()
    self:OnDisable()
end



UIBaseViewModel.__init = __init
UIBaseViewModel.__delete = __delete
UIBaseViewModel.OnDestroy = OnDestroy
UIBaseViewModel.Activate = Activate
UIBaseViewModel.Deactivate = Deactivate
UIBaseViewModel.OnCreate = OnCreate
UIBaseViewModel.OnEnable = OnEnable
UIBaseViewModel.OnDisable = OnDisable
UIBaseViewModel.OnAddListener = OnAddListener
UIBaseViewModel.OnRemoveListener = OnRemoveListener
UIBaseViewModel.AddDataListener = AddDataListener
UIBaseViewModel.RemoveDataListener = RemoveDataListener


return UIBaseViewModel