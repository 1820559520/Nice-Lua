local TimeUtil = {}

-- -- ��һ��ʱ����ת����"00:00:00"��ʽ
function TimeUtil:getTimeString1(timeInt)
    if (tonumber(timeInt) <= 0) then
        return "00:00:00"
    else
        return string.format("%02d:%02d:%02d", math.floor(timeInt/(60*60)), math.floor((timeInt/60)%60), timeInt%60)
    end
end

-- ��һ��ʱ����ת����"00:00"��ʽ
function TimeUtil:getTimeString(timeInt)
    if (tonumber(timeInt) <= 0) then
        return "00:00"
    else
        return string.format("%02d:%02d", math.floor((timeInt/60)%60), timeInt%60)
    end
end

-- ��һ��ʱ����ת����"00"�ָ�ʽ
function TimeUtil:getTimeMinuteString(timeInt)
    if (tonumber(timeInt) <= 0) then
        return "00"
    else
        return string.format("%02d", math.floor((timeInt/60)%60))
    end
end

-- ��һ��ʱ����ת����"00�����ʽ
function TimeUtil:getTimeSecondString(timeInt)
    if (tonumber(timeInt) <= 0) then
        return "00"
    else
        return string.format("%02d", timeInt%60)
    end
end

-- ��һ��ʱ���ת��
function TimeUtil:getTimeStampString(time,splitStr,haveSec)
    if not time then
        return ""
    end
    time = tonumber(time)
    if time<0 then
        return ""
    end
    if not splitStr then splitStr="_" end
    local date = os.date("*t",time)
    local year = date.year
    local month = date.month
    if tonumber(month)<10 then
        month = "0"..month
    end
    local day = date.day
    if tonumber(day)<10 then
        day = "0"..day
    end
    local hour = date.hour
    if tonumber(hour)<10 then
        hour = "0"..hour
    end
    local min = date.min
    if tonumber(min)<10 then
        min = "0"..min
    end
    if haveSec==true then
        local sec = date.sec
        if tonumber(sec)<10 then
            sec = "0"..sec
        end
        return date.year..splitStr..month..splitStr..day.."  "..hour..":"..min.."  "..sec
    end
    return date.year..splitStr..month..splitStr..day.."  "..hour..":"..min
end

function TimeUtil:getTimeSimpleString(time,splitStr,ishaveYear, isnohaveTime)
    if not time then
        return ""
    end
    time = tonumber(time)
    if time<0 then
        return ""
    end

    if not splitStr then splitStr="_" end
    local date = os.date("*t",time)
    local year = date.year
    local month = date.month
    if tonumber(month)<10 then
        month = "0"..month
    end
    local day = date.day
    if tonumber(day)<10 then
        day = "0"..day
    end
    local hour = date.hour
    if tonumber(hour)<10 then
        hour = "0"..hour
    end
    local min = date.min
    if tonumber(min)<10 then
        min = "0"..min
    end
    -- 
    if ishaveYear then
        if isnohaveTime then
            return year..splitStr..month..splitStr..day
        else
            return year..splitStr..month..splitStr..day.."  "..hour..":"..min
        end
    else
        return month..splitStr..day.."  "..hour..":"..min
    end
end

-- Author: KevinYu
-- Date: 2015-11-12 11:44:29
-- ��չ����

--[[
os.date("*t", time) ���ص�table
time = {
    "day"   = 12 ��
    "hour"  = 15 ʱ
    "isdst" = false �Ƿ�����ʱ
    "min"   = 7 ��
    "month" = 11 ��
    "sec"   = 12 ��
    "wday"  = 5 ���ڼ�(������Ϊ1)
    "yday"  = 316 һ���еĵڼ���
    "year"  = 2015 ��
 }]]

--��ȡ�����������
function TimeUtil:getMonthData(time)
    local data = {}
    data.firstDayWeek = self:getWeekOfMonthFirstDay(time)
    data.year = self:getYear(time)
    data.month = self:getMonth(time)
    data.day = self:getDay(time)
    data.monthDays = self:getMonthDays_(data.year, data.month)

    return data
end

--��ȡ����һ�������ڼ�
function TimeUtil:getWeekOfMonthFirstDay(time)
    time = tonumber(time)
    local tab = os.date("*t", time)
    local year, month, day, wday = tab.year, tab.month, tab.day, tab.wday
    local f_wday = 1
    day = day % 7 --ת����1-7�Ŷ�Ӧ�ĵڼ���  ������Ϊ��1��
    if day == 0 then
        f_wday = wday + 1
    else
        if day > wday then
            f_wday = wday - day + 8
        else
            f_wday = wday - day + 1
        end
    end

    return f_wday - 1  --����0 - 6 ��Ӧ������-������
end

--�ж��Ƿ�Ϊ����
function TimeUtil:isLeapYear(year)
    if (year % 4 == 0 and year % 100 ~= 0) or (year % 400 == 0) then
        return true
    end

    return false
end

--ÿ���¶�Ӧ������
local months = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}

function TimeUtil:getMonthDays_(year, month)
    if month == 2 then
        if self:isLeapYear(year) then
            return 29
        else
            return 28
        end
    else
        return months[month]
    end
end

function TimeUtil:getMonthDays(time)
    local tab = os.date("*t", time)
    return self:getMonthDays_(tab.year, tab.month)
end

--��
function TimeUtil:getYear(time)
    return tonumber(os.date("%Y", time))
end

--��
function TimeUtil:getMonth(time)
    return tonumber(os.date("%m", time))
end

--��
function TimeUtil:getDay(time)
    return tonumber(os.date("%d", time))
end

--ʱ
function TimeUtil:getHour(time)
    return tonumber(os.date("%H", time))
end

--��
function TimeUtil:getMinutes(time)
    return tonumber(os.date("%M", time))
end

--��
function TimeUtil:getSeconds(time)
    return tonumber(os.date("%S", time))
end

--�����еĵڼ��죬������Ϊ 0  ��wday���Բ�һ��
function TimeUtil:getWeekDay(time)
    return tonumber(os.date("%w", time))
end

--�������ʱ���ʽ
function TimeUtil:getFootballMathTime(time, separator)
    separator = separator or " "
    local date = os.date("*t", time)
    local dayStr = string.format("%02d/%02d", date.month, date.day)
    local timeStr = string.format("%02d:%02d", date.hour, date.min)

    return dayStr .. separator .. timeStr
end

return ConstClass("TimeUtil", TimeUtil)
