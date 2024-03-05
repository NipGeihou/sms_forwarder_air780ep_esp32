local utils = {}

function utils.bool_to_number(value)
    return value and 1 or 0
end

function utils.is_empty(str)
    return str == nil or str == ""
end

function utils.clear_table(table)
    for i = 0, #table do
        table[i] = nil
    end
end

-- 从短信内容中解析出验证码，返回最长的一段数字
function utils.extract_verification_code(smsContent)
    local longestCode = ""
    local currentCode = ""

    for i = 1, #smsContent do
        local char = smsContent:sub(i, i)
        if char:match("%d") then
            currentCode = currentCode .. char
        else
            if #currentCode >= 4 and #currentCode > #longestCode then
                longestCode = currentCode
            end
            currentCode = ""
        end
    end

    -- 检查最后一段数字
    if #currentCode >= 4 and #currentCode > #longestCode then
        longestCode = currentCode
    end

    -- 如果没有找到数字，返回原文
    return #longestCode > 0 and longestCode or smsContent
end

return utils
