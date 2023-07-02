local rnd = {}
local bonusNames = { -- Only for rury_vip
    ['prem'] = true,
    ['high'] = true,
    ['med'] = true,
    ['rare'] = true,
    ['rarer'] = true,
    ['risky'] = true,
    ['unbelieveable'] = true,
    ['imposible'] = true
}

local getRandomRewardWithCounts = function(rndTab, rndBonus)
    local randomTable = rnd.create(rndTab.chance, rndBonus)
    local rewardType = rnd.tab(randomTable)
    local rewardIndex = math.random(1, #rndTab.rewards[rewardType])
    local rewardName = rndTab.rewards[rewardType][rewardIndex][1]
    local randomCount = rnd.tab(rnd.create(rndTab.rewards[rewardType][rewardIndex][2]))
    return rewardName, randomCount
end

local getRandomReward = function(rndTab, rndBonus)
    local randomTable = rnd.create(rndTab.chance, rndBonus)
    local rewardType = rnd.tab(randomTable)
    local rewardIndex = math.random(1, #rndTab.rewards[rewardType])
    local rewardName = rndTab.rewards[rewardType][rewardIndex]
    return rewardName
end

rnd.tab = function( t )
    return t[ math.random( 1, #t ) ]
end

rnd.create = function(t, rndBonus)
    local res = {}
    local count = 0
    for p1, p2 in pairs(t) do
        if rndBonus and bonusNames[p1] then
            p2 = math.ceil(p2+(p2*rndBonus))
        end
        for k = 1, p2 do
            res[#res+1] = p1
        end
    end
    return res
end

exports("getRandomRewardWithCounts", getRandomRewardWithCounts)
exports("getRandomReward", getRandomReward)
