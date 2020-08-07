local PBUtil = BaseClass("PBUtil", Singleton)

-- ��������PB
local function LoadPB(self)
    local pbFiles = {
        "Net/PB/OuterMessage.pb",
    }

    --�༭���º��ƶ��ˣ�����λ�ò�ͬ
    if(CS.GameUtility.GetPlatform() == "WindowsEditor")then
        table.walk(pbFiles,function(i,path)
            print(path.." pb load success")
            assert(pb.loadfile("Assets/LuaScripts/"..path))
        end)
    else
        table.walk(pbFiles,function(i,path)
            ResourcesManager:GetInstance():LoadAsync(path..".bytes", typeof(CS.UnityEngine.TextAsset), function(data)
                print(path.." pb load addr success")
                assert(pb.load(data.bytes))
            end)
        end)
    end

end

PBUtil.LoadPB = LoadPB
return PBUtil
