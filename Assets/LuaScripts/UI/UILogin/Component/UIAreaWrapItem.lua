--[[
-- added by wsh @ 2017-12-11
-- UILoginģ��UILoginView�����з������б�Ŀɸ���Item
--]]

local UIAreaWrapItem = BaseClass("UIAreaWrapItem", UIWrapComponent)
local base = UIWrapComponent


-- ����
local function OnCreate(self)
    base.OnCreate(self)
    -- �����ʼ��
    self.area_btn_text = self:AddComponent(UIText, "Text")

end

-- ���������ʱ�ص��ú�����ִ�������ˢ��
local function OnRefresh(self, real_index, check)
    local area_id = self.view.area_ids[real_index + 1]
    local btn_name = LangUtil.GetServerAreaName(area_id)
    self.area_btn_text:SetText(btn_name)
end

-- �������˰�ť�飬��ť�����ʱ�ص��ú���
local function OnClick(self, toggle_btn, real_index, check)
    if check then
        self.view:SetSelectedArea(real_index)
    end
end

UIAreaWrapItem.OnCreate = OnCreate
UIAreaWrapItem.OnRefresh = OnRefresh
UIAreaWrapItem.OnClick = OnClick

return UIAreaWrapItem