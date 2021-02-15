local Item         = {}
      Item.__index = Item

function Item:new()
    local class = {}

    ----------VARIABLES-------------

    ----------VARIABLES-------------

    setmetatable( class, Item )
    return class
end

function Item:IsEquipped(slot)
    local ts = Game.GetTransactionSystem()
    local pl = Game.GetPlayer()

    if(ts:GetItemInSlot(pl, TweakDBID:new(slot)) ~= nil) then
        return true
    end

    return false
end

function Item:AddToInventory(name)
    local gameItemID = GetSingleton('gameItemID')
    local tdbid      = TweakDBID.new(name)
    local itemID     = gameItemID:FromTDBID(tdbid)
    local player     = Game.GetPlayer()
    local ts         = Game.GetTransactionSystem()

    if(ts:HasItem(player, itemID) == false) then
        Game.AddToInventory(name, 1)
    end
end

function Item:Equip(name, slot)
    if slot == "TppHead" then
        local ts      = Game.GetTransactionSystem()
        local player  = Game.GetPlayer()
        local tpp     = player:FindComponentByName(CName.new("TPPRepresentation"))
        local obj     = NewObject('gameFppRepDetachedObjectInfo')
        obj.slotID    = TweakDBID.new("TppHead")
        obj.itemTDBID = TweakDBID.new(name)

        tpp.detachedObjectInfo = {obj}
        tpp.detachedObjectInfo[1].itemTDBID = TweakDBID.new(name)
        print('working')
    end
    Item:AddToInventory(name)
    Game.EquipItemOnPlayer(name, slot)
end

return Item:new()