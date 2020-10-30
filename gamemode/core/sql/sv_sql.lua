//=============================================================================//
//========= Citizen Networks, All rights reserved. ============//
//
// Name: NAME (SERVER CLIENT SHARED)
// Author: Razor 1911
// Created: 09.11.2019
// Modified: 09.11.2019
//
//=============================================================================//

function GM:SetupDataBase()
	
	MySQLite.begin()
    -- Gotta love the difference between SQLite and MySQL
    local AUTOINCREMENT = MySQLite.isMySQL() and "AUTO_INCREMENT" or "AUTOINCREMENT"

    -- Table that holds all position data (jail, spawns etc.)
    -- Queue these queries because other queries depend on the existence of the darkrp_position table
    -- Race conditions could occur if the queries are executed simultaneously
    MySQLite.queueQuery([[
        CREATE TABLE IF NOT EXISTS darkrp_position(
            id INTEGER NOT NULL PRIMARY KEY ]] .. AUTOINCREMENT .. [[,
            map VARCHAR(45) NOT NULL,
            type CHAR(1) NOT NULL,
            x INTEGER NOT NULL,
            y INTEGER NOT NULL,
            z INTEGER NOT NULL
        );
    ]])

    -- team spawns require extra data
    MySQLite.queueQuery([[
        CREATE TABLE IF NOT EXISTS darkrp_jobspawn(
            id INTEGER NOT NULL PRIMARY KEY REFERENCES darkrp_position(id)
                ON UPDATE CASCADE
                ON DELETE CASCADE,
            teamcmd VARCHAR(255) NOT NULL
        );
    ]])

    -- This table is kept for compatibility with older addons and websites
    -- See https://github.com/FPtje/DarkRP/issues/819
    MySQLite.query([[
        CREATE TABLE IF NOT EXISTS playerinformation(
            uid BIGINT NOT NULL,
            steamID VARCHAR(50) NOT NULL PRIMARY KEY
        )
    ]])

    -- Player information
    MySQLite.query([[
        CREATE TABLE IF NOT EXISTS darkrp_player(
            uid BIGINT NOT NULL PRIMARY KEY,
            rpname VARCHAR(45),
            salary INTEGER NOT NULL DEFAULT 45,
            wallet BIGINT NOT NULL
        );
    ]])

    -- Door data
    MySQLite.query([[
        CREATE TABLE IF NOT EXISTS darkrp_door(
            idx INTEGER NOT NULL,
            map VARCHAR(45) NOT NULL,
            title VARCHAR(25),
            isLocked BOOLEAN,
            isDisabled BOOLEAN NOT NULL DEFAULT FALSE,
            PRIMARY KEY(idx, map)
        );
    ]])

    -- Some doors are owned by certain teams
    MySQLite.query([[
        CREATE TABLE IF NOT EXISTS darkrp_doorjobs(
            idx INTEGER NOT NULL,
            map VARCHAR(45) NOT NULL,
            job VARCHAR(255) NOT NULL,
            PRIMARY KEY(idx, map, job)
        );
    ]])

    -- Door groups
    MySQLite.query([[
        CREATE TABLE IF NOT EXISTS darkrp_doorgroups(
            idx INTEGER NOT NULL,
            map VARCHAR(45) NOT NULL,
            doorgroup VARCHAR(100) NOT NULL,
            PRIMARY KEY(idx, map)
        )
    ]])

    MySQLite.queueQuery([[
        CREATE TABLE IF NOT EXISTS darkrp_dbversion(version INTEGER NOT NULL PRIMARY KEY)
    ]])

    -- Load the last DBVersion into DarkRP.DBVersion, to allow checks to see whether migration is needed.
    MySQLite.queueQuery([[
        SELECT MAX(version) AS version FROM darkrp_dbversion
    ]], function(data) DarkRP.DBVersion = data and data[1] and tonumber(data[1].version) or 20190914 end)

    MySQLite.queueQuery([[
        REPLACE INTO darkrp_dbversion VALUES(20190914)
    ]])

MySQLite.commit(fp{migrateDB, -- Migrate the database
    function() -- Initialize the data after all the tables have been created
        setUpNonOwnableDoors()
        setUpTeamOwnableDoors()
        setUpGroupDoors()

        if MySQLite.isMySQL() then -- In a listen server, the connection with the external database is often made AFTER the listen server host has joined,
                                    --so he walks around with the settings from the SQLite database
            for _, v in ipairs(player.GetAll()) do
                DarkRP.offlinePlayerData(v:SteamID(), function(data)
                    local Data = data and data[1]
                    if not IsValid(v) or not Data then return end

                    v:setDarkRPVar("rpname", Data.rpname)
                    v:setSelfDarkRPVar("salary", Data.salary)
                    v:setDarkRPVar("money", Data.wallet)
                end)
            end
        end

        hook.Call("DarkRPDBInitialized")
    end})
end