# ClanGui

Clan management UI for viewing and managing clans.

## UI Structure (Create in Roblox Studio)

**ClanScreenGui** (ScreenGui)
- **ClanFrame** (Frame) - Main container
  - **ClanInfoPanel** (Frame) - Clan information
    - **ClanName** (TextLabel) - Clan name
    - **ClanIcon** (ImageLabel) - Clan icon
    - **MemberList** (ScrollingFrame) - List of clan members
      - **MemberTemplate** (Frame) - Template for each member
        - **MemberName** (TextLabel) - Member name
        - **MemberRole** (TextLabel) - Member role
  - **ActionPanel** (Frame) - Clan actions
    - **JoinClanButton** (TextButton) - Join a clan
    - **CreateClanButton** (TextButton) - Create new clan
    - **LeaveClanButton** (TextButton) - Leave current clan
    - **InviteButton** (TextButton) - Invite player
  - **CloseButton** (TextButton) - Close clan UI

## Scripts

- **Scripts/ClanGui.client.lua** - Clan UI controller

## Notes

- Create ScreenGui in Roblox Studio
- Add UI elements as documented above
- Connect to ClanController for clan operations

