# Clan GUI

Manage clan membership, roles, invites, home teleport, and clan settings.

## Structure

```
ClanGui/
   ClanScreenGui (ScreenGui)
      ├── Frame_ClanHome
      │      ├── ClanNameLabel
      │      ├── MemberList (ScrollingFrame)
      │      ├── InviteButton
      │      ├── LeaveClanButton
      │      └── TeleportHomeButton
      │
      └── Frame_NoClan
             ├── CreateClanButton
             ├── JoinClanButton
             └── ClanInfoLabel
   Scripts/
     └── ClanGui.client.lua
```

## Wireframe

```
 -----------------------------------------------------------
| CLAN: STARFALL PRIDE                                      |
| --------------------------------------------------------- |
| MEMBERS                                                    |
|  - LunaLynx (Leader)                                       |
|  - NebulaPanther                                           |
|  - GalaxyKitty                                             |
|                                                           |
| [ INVITE ]    [ TELEPORT HOME ]    [ LEAVE CLAN ]          |
 -----------------------------------------------------------
```

## Behavior

### When in a Clan (Frame_ClanHome visible)
- **ClanNameLabel** → Shows clan name
- **MemberList** → Scrollable list of clan members with roles
- **InviteButton** → Opens player list for inviting
- **TeleportHomeButton** → Teleports to clan home (server validates)
- **LeaveClanButton** → Leaves current clan

### When not in a Clan (Frame_NoClan visible)
- **CreateClanButton** → Opens create clan popup
- **JoinClanButton** → Opens join clan interface
- **ClanInfoLabel** → Information about clans

## Script

See `Scripts/ClanGui.client.lua` for implementation.


