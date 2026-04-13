{
  imports = [ ./module.nix ];

  services.arrpc.enable = true;

  programs.equibop = {
    enable = true;
    settings = {
      arRPC = true;
      discordBranch = "stable";
      minimizeToTray = false;
    };
    # nix-instantiate --eval -E 'with (import <nixpkgs> {}).lib; fromJSON (readFile ./settings/settings.json)' | wl-copy
    equicord.settings = {
      autoUpdate = true;
      autoUpdateNotification = true;
      cloud = {
        authenticated = false;
        settingsSync = false;
        settingsSyncVersion = 1774438444129;
        url = "https://cloud.equicord.org/";
      };
      disableMinSize = false;
      eagerPatches = false;
      enableOnlineThemes = true;
      enableReactDevtools = false;
      enabledThemeLinks = [ ];
      enabledThemes = [ ];
      frameless = false;
      ignoreResetWarning = false;
      mainWindowFrameless = false;
      notifications = {
        logLimit = 50;
        missed = true;
        position = "bottom-right";
        timeout = 5000;
        useNative = "always";
      };
      pinnedThemes = [ ];
      plugins = {
        AccountPanelServerProfile = {
          enabled = true;
          prioritizeServerProfile = false;
        };
        AllCallTimers = {
          enabled = true;
          format = "stopwatch";
        };
        AltKrispSwitch = {
          enabled = true;
        };
        AlwaysAnimate = {
          enabled = false;
        };
        AlwaysExpandProfiles = {
          enabled = false;
        };
        AlwaysExpandRoles = {
          enabled = true;
          hideArrow = false;
        };
        AlwaysTrust = {
          enabled = false;
        };
        AmITyping = {
          enabled = false;
        };
        Anammox = {
          billing = false;
          dms = true;
          emojiList = true;
          enabled = true;
          gift = true;
          quests = false;
          serverBoost = true;
        };
        Animalese = {
          enabled = false;
        };
        AnonymiseFileNames = {
          enabled = false;
        };
        AppleMusicRichPresence = {
          enabled = false;
        };
        AtSomeone = {
          enabled = false;
        };
        AudioBookShelfRichPresence = {
          enabled = false;
        };
        AudioPlayerAPI = {
          enabled = true;
        };
        AutoZipper = {
          enabled = false;
        };
        BadgeAPI = {
          enabled = true;
        };
        BannersEverywhere = {
          enabled = false;
        };
        BetterActivities = {
          enabled = false;
        };
        BetterAudioPlayer = {
          enabled = false;
        };
        BetterBanReasons = {
          enabled = false;
        };
        BetterBlockedUsers = {
          enabled = false;
        };
        BetterCommands = {
          allowNewlinesInCommands = true;
          autoFillArguments = true;
          enabled = true;
        };
        BetterFolders = {
          enabled = false;
        };
        BetterGifAltText = {
          enabled = false;
        };
        BetterGifPicker = {
          enabled = false;
        };
        BetterInvites = {
          enabled = true;
        };
        BetterNotesBox = {
          enabled = true;
          hide = false;
          noSpellCheck = true;
        };
        BetterPlusReacts = {
          enabled = false;
        };
        BetterQuickReact = {
          enabled = false;
        };
        BetterRoleContext = {
          enabled = false;
        };
        BetterRoleDot = {
          enabled = false;
        };
        BetterSessions = {
          enabled = false;
        };
        BetterSettings = {
          enabled = false;
        };
        BetterUploadButton = {
          enabled = false;
        };
        BiggerStreamPreview = {
          enabled = true;
        };
        BlockKeywords = {
          enabled = false;
        };
        BlockKrisp = {
          enabled = false;
        };
        BlurNSFW = {
          enabled = false;
        };
        BypassPinPrompt = {
          enabled = false;
        };
        BypassStatus = {
          enabled = false;
        };
        CallTimer = {
          allCallTimers = true;
          enabled = true;
          format = "stopwatch";
          showRoleColor = true;
          showSeconds = true;
          showWithoutHover = true;
          trackSelf = true;
          watchLargeGuilds = false;
        };
        ChannelBadges = {
          enabled = false;
        };
        ChannelTabs = {
          animationCloseRotation = true;
          animationCompactExpand = true;
          animationDragDrop = true;
          animationEnterExit = true;
          animationHover = true;
          animationIconPop = true;
          animationMentionGlow = true;
          animationPlusPulse = true;
          animationQuestsActive = true;
          animationResizeHandle = true;
          animationSelectedBackground = true;
          animationSelectedBorder = true;
          animationSelection = true;
          animationTabPositioning = true;
          animationTabShadows = true;
          bookmarksIndependentFromTabs = true;
          compactAutoExpandOnHover = true;
          compactAutoExpandSelected = true;
          createNewTabIfNotExists = false;
          enableHotkeys = true;
          enabled = false;
          hotkeyCount = 3;
          maxOpenTabs = 0;
          noPomeloNames = false;
          onStartup = "nothing";
          oneTabPerServer = false;
          openNewTabsInCompactMode = false;
          renderAllTabs = false;
          showBookmarkBar = true;
          showResizeHandle = true;
          showStatusIndicators = true;
          switchToExistingTab = false;
          tabBarPosition = "top";
          tabWidthScale = 91;
          widerTabsAndBookmarks = false;
        };
        CharacterCounter = {
          enabled = false;
        };
        ChatInputButtonAPI = {
          enabled = true;
        };
        CleanChannelName = {
          enabled = false;
        };
        CleanUserArea = {
          enabled = false;
        };
        CleanerChannelGroups = {
          enabled = false;
        };
        ClearURLs = {
          enabled = true;
        };
        ClickableRoles = {
          enabled = false;
        };
        ClientSideBlock = {
          enabled = false;
        };
        ClientTheme = {
          enabled = false;
        };
        ColorSighted = {
          enabled = false;
        };
        CommandPalette = {
          enabled = false;
        };
        CommandsAPI = {
          enabled = true;
        };
        ConsoleJanitor = {
          enabled = false;
        };
        ConsoleShortcuts = {
          enabled = false;
        };
        ContentWarning = {
          enabled = false;
        };
        ContextMenuAPI = {
          enabled = true;
        };
        CopyEmojiMarkdown = {
          enabled = false;
        };
        CopyFileContents = {
          enabled = false;
        };
        CopyProfileColors = {
          enabled = false;
        };
        CopyStatusUrls = {
          enabled = false;
        };
        CopyStickerLinks = {
          enabled = false;
        };
        CopyUserMention = {
          enabled = true;
        };
        CopyUserURLs = {
          enabled = true;
        };
        CrashHandler = {
          enabled = true;
        };
        CtrlEnterSend = {
          enabled = false;
          sendMessageInTheMiddleOfACodeBlock = true;
          submitRule = "ctrl+enter";
        };
        CursorBuddy = {
          enabled = false;
        };
        CustomCommands = {
          enabled = false;
        };
        CustomFolderIcons = {
          enabled = false;
        };
        CustomIdle = {
          enabled = true;
          idleTimeout = 0;
          remainInIdle = false;
        };
        CustomRPC = {
          enabled = false;
        };
        CustomSounds = {
          enabled = false;
        };
        CustomTimestamps = {
          enabled = false;
        };
        CustomUserColors = {
          enabled = false;
        };
        Dearrow = {
          enabled = false;
        };
        Declutter = {
          enabled = false;
        };
        DecodeBase64 = {
          enabled = false;
        };
        Decor = {
          enabled = false;
        };
        DisableCallIdle = {
          enabled = true;
        };
        DisableCameras = {
          enabled = false;
        };
        DisableDeepLinks = {
          enabled = true;
        };
        DiscordDevBanner = {
          enabled = false;
        };
        DontFilterMe = {
          enabled = true;
        };
        DontRoundMyTimestamps = {
          enabled = false;
        };
        DragFavoriteEmotes = {
          enabled = false;
        };
        Dragify = {
          enabled = false;
        };
        DynamicImageModalAPI = {
          enabled = true;
        };
        ElementHighlighter = {
          enabled = false;
        };
        EquicordHelper = {
          accountStandingButton = false;
          disableAdoptTagPrompt = true;
          disableCreateDMButton = false;
          disableDMContextMenu = false;
          enabled = true;
          forceRoleIcon = false;
          noBulletPoints = false;
          noDefaultHangStatus = false;
          noMirroredCamera = false;
          noModalAnimation = true;
          refreshSlashCommands = false;
          removeActivitySection = false;
          restoreFileDownloadButton = false;
          showYourOwnActivityButtons = false;
        };
        EquicordToolbox = {
          enabled = false;
        };
        Equissant = {
          enabled = false;
        };
        ExitSounds = {
          enabled = false;
        };
        Experiments = {
          enabled = false;
        };
        ExportMessages = {
          enabled = false;
        };
        ExpressionCloner = {
          enabled = false;
        };
        F8Break = {
          enabled = false;
        };
        FakeNitro = {
          disableEmbedPermissionCheck = false;
          emojiSize = 48;
          enableEmojiBypass = true;
          enableStickerBypass = true;
          enableStreamQualityBypass = true;
          enabled = true;
          hyperLinkText = "{{NAME}}";
          stickerSize = 160;
          transformCompoundSentence = false;
          transformEmojis = true;
          transformStickers = true;
          useEmojiHyperLinks = true;
          useStickerHyperLinks = true;
        };
        FakeProfileThemes = {
          enabled = true;
          nitroFirst = true;
        };
        FastDeleteChannels = {
          enabled = false;
        };
        FavoriteEmojiFirst = {
          enabled = false;
        };
        FavoriteGifSearch = {
          enabled = false;
        };
        FavouriteAnything = {
          enabled = false;
        };
        FileUpload = {
          enabled = false;
        };
        FindReply = {
          enabled = false;
        };
        FixCodeblockGap = {
          enabled = false;
        };
        FixFileExtensions = {
          enabled = false;
        };
        FixImagesQuality = {
          enabled = false;
        };
        FixSpotifyEmbeds = {
          enabled = false;
        };
        FixYoutubeEmbeds = {
          enabled = false;
        };
        FollowVoiceUser = {
          enabled = false;
        };
        FontLoader = {
          enabled = false;
        };
        ForceOwnerCrown = {
          enabled = true;
        };
        ForwardAnywhere = {
          enabled = true;
        };
        FrequentQuickSwitcher = {
          enabled = false;
        };
        FriendCloud = {
          enabled = false;
        };
        FriendCodes = {
          enabled = false;
        };
        FriendInvites = {
          enabled = false;
        };
        FriendTags = {
          enabled = false;
        };
        FriendsSince = {
          enabled = false;
        };
        FriendshipRanks = {
          enabled = false;
        };
        FullSearchContext = {
          enabled = false;
        };
        FullUserInChatbox = {
          enabled = false;
        };
        FullVCPFP = {
          enabled = false;
        };
        GameActivityToggle = {
          enabled = false;
        };
        GensokyoRadioRPC = {
          enabled = false;
        };
        Ghosted = {
          enabled = false;
        };
        GifCollections = {
          enabled = false;
        };
        GifPaste = {
          enabled = false;
        };
        GifRoulette = {
          enabled = false;
        };
        GitHubRepos = {
          enabled = true;
          showInMiniProfile = true;
          showRepositoryTab = true;
        };
        GlobalBadges = {
          enabled = false;
        };
        GlobalNicknames = {
          enabled = false;
        };
        GoogleThat = {
          defaultEngine = "Google";
          enabled = false;
          hyperlink = false;
        };
        GreetStickerPicker = {
          enabled = false;
        };
        GuildPickerDumper = {
          enabled = false;
        };
        GuildTagSettings = {
          enabled = false;
        };
        HeaderBarAPI = {
          enabled = true;
        };
        HideChatButtons = {
          enabled = false;
        };
        HideMedia = {
          enabled = false;
        };
        HideMessages = {
          enabled = false;
        };
        HideServers = {
          enabled = false;
        };
        HolyNotes = {
          enabled = false;
        };
        HomeTyping = {
          enabled = true;
        };
        HopOn = {
          enabled = false;
        };
        Husk = {
          enabled = false;
        };
        ILoveSpam = {
          enabled = false;
        };
        IRememberYou = {
          enabled = false;
        };
        IconViewer = {
          enabled = false;
        };
        IdleAutoRestart = {
          enabled = false;
        };
        IgnoreActivities = {
          enabled = false;
        };
        IgnoreCalls = {
          enabled = false;
        };
        IgnoreTerms = {
          enabled = true;
        };
        ImageFilename = {
          enabled = false;
        };
        ImageLink = {
          enabled = false;
        };
        ImageZoom = {
          enabled = false;
        };
        ImgToGif = {
          enabled = false;
        };
        ImplicitRelationships = {
          enabled = true;
          sortByAffinity = true;
        };
        InRole = {
          enabled = false;
        };
        Ingtoninator = {
          enabled = false;
        };
        InstantScreenshare = {
          enabled = false;
        };
        InvisibleChat = {
          enabled = false;
        };
        InviteDefaults = {
          enabled = false;
        };
        IrcColors = {
          enabled = false;
        };
        JellyfinRichPresence = {
          enabled = false;
        };
        JumpTo = {
          enabled = true;
        };
        Jumpscare = {
          enabled = false;
        };
        KeepCurrentChannel = {
          enabled = false;
        };
        KeyboardNavigation = {
          enabled = false;
        };
        KeyboardSounds = {
          enabled = false;
        };
        KeywordNotify = {
          enabled = false;
        };
        LastActive = {
          enabled = false;
        };
        LastFMRichPresence = {
          enabled = false;
        };
        ListenBrainzRPC = {
          enabled = false;
        };
        LoadingQuotes = {
          enabled = false;
        };
        LoginWithQR = {
          enabled = false;
        };
        MediaPlaybackSpeed = {
          enabled = false;
        };
        MemberCount = {
          enabled = true;
          memberList = true;
          toolTip = true;
          voiceActivity = true;
        };
        MemberListDecoratorsAPI = {
          enabled = true;
        };
        MentionAvatars = {
          enabled = false;
        };
        MessageAccessoriesAPI = {
          enabled = true;
        };
        MessageBurst = {
          enabled = false;
        };
        MessageClickActions = {
          addAdditionalReacts = false;
          enabled = false;
        };
        MessageColors = {
          blockView = 1;
          enableShortHexCodes = true;
          enabled = true;
          renderType = 2;
        };
        MessageDecorationsAPI = {
          enabled = true;
        };
        MessageEventsAPI = {
          enabled = true;
        };
        MessageFetchTimer = {
          enabled = false;
        };
        MessageLatency = {
          enabled = false;
        };
        MessageLinkEmbeds = {
          enabled = false;
        };
        MessageLinkTooltip = {
          enabled = false;
        };
        MessageLogger = {
          collapseDeleted = false;
          deleteStyle = "text";
          enabled = true;
          ignoreBots = false;
          ignoreChannels = "";
          ignoreGuilds = "";
          ignoreSelf = false;
          ignoreUsers = "";
          inlineEdits = true;
          logDeletes = true;
          logEdits = true;
          separatedDiffs = false;
          showEditDiffs = true;
        };
        MessageLoggerEnhanced = {
          ShowLogsButton = true;
          ShowWhereMessageIsFrom = true;
          alwaysLogCurrentChannel = true;
          alwaysLogDirectMessages = true;
          attachmentFileExtensions = "png,jpg,jpeg,gif,webp,mp4,webm,mp3,ogg,wav";
          attachmentSizeLimitInMegabytes = 12;
          blacklistedIds = "457912077277855764";
          cacheLimit = 1000;
          cacheMessagesFromServers = true;
          enabled = true;
          hideMessageFromMessageLoggers = false;
          hideMessageFromMessageLoggersDeletedMessage = "redacted eh";
          ignoreBots = false;
          ignoreMutedCategories = true;
          ignoreMutedChannels = true;
          ignoreMutedGuilds = true;
          ignoreSelf = false;
          ignoreWebhooks = false;
          imageCacheDir = "/home/perchun/.config/equibop/MessageLoggerData/savedImages";
          logsDir = "/home/perchun/.config/equibop/MessageLoggerData";
          messageLimit = 200;
          messagesToDisplayAtOnceInLogs = 100;
          permanentlyRemoveLogByDefault = false;
          saveImages = true;
          saveMessages = true;
          sortNewest = true;
          timeBasedCleanupMinutes = 0;
          whitelistedIds = "";
        };
        MessageNotifier = {
          enabled = false;
        };
        MessagePeek = {
          enabled = false;
        };
        MessagePopoverAPI = {
          enabled = true;
        };
        MessageTranslate = {
          enabled = false;
        };
        MessageUpdaterAPI = {
          enabled = true;
        };
        MicLoopbackTester = {
          enabled = false;
        };
        MiddleClickTweaks = {
          enabled = true;
          pasteScope = "always";
          pasteThreshold = 100;
        };
        MoreCommands = {
          enabled = false;
        };
        MoreKaomoji = {
          enabled = false;
        };
        MoreQuickReactions = {
          enabled = false;
        };
        MoreStickers = {
          enabled = false;
        };
        MoreUserTags = {
          enabled = false;
        };
        Moyai = {
          enabled = false;
        };
        MusicControls = {
          enabled = false;
        };
        MutualGroupDMs = {
          enabled = true;
        };
        NeverPausePreviews = {
          enabled = false;
        };
        NewGuildSettings = {
          enabled = false;
          events = true;
          everyone = true;
          guild = true;
          highlights = true;
          messages = 3;
          mobilePush = true;
          role = true;
          showAllChannels = true;
          voiceChannels = false;
        };
        NewPluginsManager = {
          enabled = false;
        };
        NicknameIconsAPI = {
          enabled = true;
        };
        NoAppsAllowed = {
          enabled = false;
        };
        NoBlockedMessages = {
          enabled = false;
        };
        NoBulletPoints = {
          enabled = false;
        };
        NoDefaultHangStatus = {
          enabled = false;
        };
        NoDevtoolsWarning = {
          enabled = false;
        };
        NoF1 = {
          enabled = true;
        };
        NoMaskedUrlPaste = {
          enabled = true;
        };
        NoMosaic = {
          enabled = false;
        };
        NoNitroUpsell = {
          enabled = true;
        };
        NoOnboarding = {
          enabled = false;
        };
        NoOnboardingDelay = {
          enabled = false;
        };
        NoPendingCount = {
          enabled = false;
        };
        NoProfileThemes = {
          enabled = true;
        };
        NoPushToTalk = {
          enabled = false;
        };
        NoReplyMention = {
          enabled = true;
          inverseShiftReply = false;
          roleList = "1234567890123445,1234567890123445";
          shouldPingListed = true;
          userList = "1234567890123445,1234567890123445";
        };
        NoRoleHeaders = {
          enabled = false;
        };
        NoServerEmojis = {
          enabled = false;
        };
        NoTrack = {
          disableAnalytics = true;
          enabled = true;
        };
        NoTypingAnimation = {
          enabled = false;
        };
        NoUnblockToJump = {
          enabled = true;
        };
        NormalizeMessageLinks = {
          enabled = false;
        };
        NotificationVolume = {
          enabled = false;
        };
        OnePingPerDM = {
          allowEveryone = false;
          allowMentions = false;
          alwaysPlaySound = false;
          channelToAffect = "both_dms";
          enabled = true;
          ignoreUsers = "";
        };
        OpenInApp = {
          enabled = true;
          epic = false;
          itunes = false;
          spotify = false;
          steam = true;
          tidal = false;
          vrcx = true;
        };
        OrbolayBridge = {
          enabled = false;
        };
        OverrideForumDefaults = {
          enabled = false;
        };
        PartyMode = {
          enabled = false;
        };
        PauseInvitesForever = {
          enabled = true;
        };
        PermissionFreeWill = {
          enabled = true;
          lockout = true;
          onboarding = true;
        };
        PermissionsViewer = {
          enabled = true;
        };
        PetPet = {
          enabled = false;
        };
        PictureInPicture = {
          enabled = false;
        };
        PinIcon = {
          enabled = true;
        };
        PingNotifications = {
          enabled = false;
        };
        PlainFolderIcon = {
          enabled = false;
        };
        PlatformIndicators = {
          ConsoleIcon = "equicord";
          colorMobileIndicator = true;
          enabled = true;
          list = true;
          messages = true;
          profiles = true;
          showBots = false;
        };
        PlatformSpoofer = {
          enabled = true;
          platform = "desktop";
        };
        PolishWording = {
          blockedWords = "";
          enabled = false;
          expandContractions = false;
          fixApostrophes = true;
          fixCapitalization = false;
          fixPunctuation = false;
          fixPunctuationFrequency = 100;
          quickDisable = false;
        };
        PreviewMessage = {
          enabled = true;
        };
        ProfileCollectionsAPI = {
          enabled = true;
        };
        ProfileSets = {
          enabled = false;
        };
        QuestFocused = {
          enabled = false;
        };
        Questify = {
          claimedSubsort = "Claimed DESC";
          completeAchievementQuestsInBackground = true;
          completeGameQuestsInBackground = true;
          completeVideoQuestsInBackground = true;
          disableFriendsListActiveNowPromotion = true;
          disableMembersListActivelyPlayingIcon = true;
          disableQuestsBadgeOnUserProfiles = false;
          disableQuestsDirectMessagesTab = false;
          disableQuestsDiscoveryTab = true;
          disableQuestsEverything = false;
          disableQuestsFetchingQuests = false;
          disableQuestsGiftInventoryRelocationNotice = true;
          disableQuestsPageSponsoredBanner = true;
          disableQuestsPopupAboveAccountPanel = true;
          enabled = true;
          expiredSubsort = "Expiring DESC";
          fetchingQuestsAlert = "discodo";
          fetchingQuestsAlertVolume = 0;
          fetchingQuestsInterval = 0;
          ignoredQuestIDs = {
            "1212520390610395179" = [ ];
            "379353300887273472" = [ ];
          };
          ignoredQuestProfile = "private";
          ignoredSubsort = "Recent DESC";
          lastQuestPageFilters = {
            task_video = {
              filter = "task_video";
              group = "task";
            };
          };
          lastQuestPageSort = "most_recent";
          makeMobileQuestsDesktopCompatible = true;
          notifyOnQuestComplete = true;
          onQuestsPage = false;
          questButtonBadgeColor = 2842239;
          questButtonDisplay = "never";
          questButtonLeftClickAction = "open-quests";
          questButtonMiddleClickAction = "plugin-settings";
          questButtonRightClickAction = "context-menu";
          questButtonUnclaimed = "pill";
          questRewardIncludeCollectibles = true;
          questRewardIncludeInGame = true;
          questRewardIncludeNitroCode = true;
          questRewardIncludeOrbs = true;
          questRewardIncludeRewardCode = true;
          rememberQuestPageFilters = true;
          rememberQuestPageSort = true;
          reorderQuests = "UNCLAIMED, CLAIMED, IGNORED, EXPIRED";
          restyleQuestsClaimed = 6105983;
          restyleQuestsExpired = 2368553;
          restyleQuestsGradient = "intense";
          restyleQuestsIgnored = 8334124;
          restyleQuestsPreload = false;
          restyleQuestsUnclaimed = 2842239;
          resumeQuestIDs = {
            achievement = [ ];
            play = [ ];
            watch = [ ];
          };
          triggerQuestsRerender = false;
          unclaimedSubsort = "Expiring ASC";
          unclaimedUnignoredQuests = 4;
        };
        QuestionMarkReplacement = {
          enabled = false;
        };
        QuickMention = {
          enabled = false;
        };
        QuickReply = {
          enabled = false;
        };
        Quoter = {
          enabled = false;
        };
        RPCEditor = {
          enabled = false;
        };
        RPCStats = {
          enabled = false;
        };
        RandomVoice = {
          enabled = false;
        };
        ReactErrorDecoder = {
          enabled = false;
        };
        ReadAllNotificationsButton = {
          enabled = false;
        };
        RecentDMSwitcher = {
          enabled = false;
        };
        RelationshipNotifier = {
          enabled = true;
          friendRequestCancels = true;
          friends = true;
          groups = true;
          notices = false;
          offlineRemovals = true;
          servers = true;
        };
        RemixRevived = {
          enabled = false;
        };
        RepeatMessages = {
          enabled = false;
        };
        ReplaceGoogleSearch = {
          enabled = false;
        };
        ReplyPingControl = {
          enabled = false;
        };
        ReplyTimestamp = {
          enabled = false;
        };
        RevealAllSpoilers = {
          enabled = true;
        };
        ReverseImageSearch = {
          enabled = false;
        };
        ReviewDB = {
          enabled = false;
          hideBlockedUsers = true;
          hideTimestamps = false;
          notifyReviews = true;
          showWarning = true;
        };
        RichMagnetLinks = {
          enabled = false;
        };
        RichPresence = {
          enabled = false;
        };
        RoleColorEverywhere = {
          enabled = false;
        };
        SaveFavoriteGIFs = {
          enabled = false;
        };
        ScheduledMessages = {
          enabled = false;
        };
        ScreenRecorder = {
          enabled = false;
        };
        SearchFix = {
          enabled = true;
        };
        SecretRingToneEnabler = {
          enabled = false;
        };
        SekaiStickers = {
          enabled = false;
        };
        SelfForward = {
          enabled = false;
        };
        SendTimestamps = {
          enabled = false;
        };
        ServerInfo = {
          enabled = true;
          sorting = "displayname";
        };
        ServerListAPI = {
          enabled = true;
        };
        ServerListIndicators = {
          enabled = false;
        };
        ServerSearch = {
          enabled = false;
        };
        Settings = {
          enabled = true;
          settingsLocation = "aboveNitro";
        };
        ShikiCodeblocks = {
          enabled = false;
        };
        ShowAllMessageButtons = {
          enabled = false;
        };
        ShowBadgesInChat = {
          enabled = false;
        };
        ShowConnections = {
          enabled = false;
        };
        ShowHiddenChannels = {
          channelStyle = 0;
          defaultAllowedUsersAndRolesDropdownState = true;
          enabled = true;
          showMode = 0;
        };
        ShowHiddenThings = {
          enabled = true;
          showInvitesPaused = true;
          showModView = true;
          showTimeouts = true;
        };
        ShowMeYourName = {
          enabled = false;
        };
        ShowMessageEmbeds = {
          enabled = false;
        };
        ShowResourceChannels = {
          enabled = false;
        };
        ShowSongName = {
          enabled = false;
        };
        ShowTimeoutDuration = {
          enabled = false;
        };
        SidebarChat = {
          enabled = false;
        };
        Signature = {
          enabled = false;
        };
        SilentMessageToggle = {
          enabled = false;
        };
        SilentTyping = {
          enabled = false;
        };
        Snowfall = {
          enabled = false;
        };
        Soggy = {
          enabled = false;
        };
        SongLink = {
          enabled = false;
        };
        SongSpotlight = {
          enabled = false;
        };
        SortFriends = {
          enabled = false;
        };
        SoundBoardLogger = {
          enabled = false;
        };
        SplitLargeMessages = {
          disableFileConversion = true;
          enabled = true;
          hardSplit = false;
          maxLength = 0;
          sendDelay = 1;
          slowmodeMax = 5;
        };
        SpotifyActivityToggle = {
          enabled = false;
        };
        SpotifyCrack = {
          enabled = false;
        };
        SpotifyShareCommands = {
          enabled = false;
        };
        StartupTimings = {
          enabled = true;
        };
        StatsfmPresence = {
          enabled = false;
        };
        StatusPresets = {
          enabled = false;
        };
        StatusWhileActive = {
          enabled = false;
        };
        SteamStatusSync = {
          enabled = false;
        };
        StickerBlocker = {
          enabled = false;
        };
        StickerPaste = {
          enabled = true;
        };
        StreamerModeOn = {
          enabled = false;
        };
        StreamingCodecDisabler = {
          enabled = false;
        };
        Summaries = {
          enabled = false;
        };
        SuperReactionTweaks = {
          enabled = true;
          superReactByDefault = false;
          superReactionPlayingLimit = 0;
          unlimitedSuperReactionPlaying = false;
        };
        SupportHelper = {
          enabled = true;
        };
        TalkInReverse = {
          enabled = false;
        };
        TextReplace = {
          enabled = false;
        };
        ThemeAttributes = {
          enabled = false;
        };
        ThemeLibrary = {
          enabled = false;
        };
        TidalEmbeds = {
          enabled = false;
        };
        TiktokTTS = {
          enabled = true;
        };
        Timezones = {
          "24h Time" = false;
          "Show Own Timezone" = true;
          askedTimezone = true;
          databaseUrl = "https://timezone.creations.works";
          enabled = true;
          preferDatabaseOverLocal = true;
          showMessageHeaderTime = true;
          showProfileTime = true;
          showTimezoneInfo = true;
          useDatabase = true;
        };
        Title = {
          enabled = false;
        };
        ToastNotifications = {
          determineServerNotifications = true;
          directMessages = true;
          disableInStreamerMode = true;
          enabled = false;
          friendActivity = true;
          friendServerNotifications = true;
          groupMessages = true;
          ignoreUsers = "";
          maxNotifications = 3;
          notifyFor = "";
          opacity = 100;
          position = "bottom-left";
          renderImages = true;
          streamingTreatment = 0;
          timeout = 5;
        };
        ToggleVideoBind = {
          enabled = false;
        };
        ToneIndicators = {
          enabled = false;
        };
        TosuRPC = {
          enabled = false;
        };
        Translate = {
          enabled = false;
        };
        "Translate+" = {
          enabled = false;
        };
        TriviaAI = {
          enabled = false;
        };
        TypingIndicator = {
          enabled = true;
          includeCurrentChannel = true;
          includeMutedChannels = false;
          indicatorMode = 3;
        };
        TypingTweaks = {
          enabled = false;
        };
        USRBG = {
          enabled = false;
        };
        Unindent = {
          enabled = false;
        };
        UnitConverter = {
          enabled = false;
          myUnits = "metric";
        };
        UniversalMention = {
          enabled = true;
          globalMention = false;
          onlyDMUsers = false;
        };
        UnlimitedAccounts = {
          enabled = true;
          maxAccounts = 0;
        };
        UnlockedAvatarZoom = {
          enabled = true;
        };
        UnreadCountBadge = {
          enabled = true;
          notificationCountLimit = false;
          showOnMutedChannels = false;
        };
        UnsuppressEmbeds = {
          enabled = false;
        };
        UrlHighlighter = {
          enabled = false;
        };
        UserAreaAPI = {
          enabled = false;
        };
        UserMessagesPronouns = {
          enabled = true;
          pronounsFormat = "LOWERCASE";
          showSelf = true;
        };
        UserPFP = {
          enabled = false;
          preferNitro = true;
        };
        UserSettingsAPI = {
          enabled = true;
        };
        UserVoiceShow = {
          enabled = false;
        };
        VCPanelSettings = {
          enabled = false;
        };
        VCSupport = {
          enabled = true;
        };
        ValidReply = {
          enabled = false;
        };
        ValidUser = {
          enabled = true;
        };
        VcNarrator = {
          enabled = false;
        };
        VcNarratorCustom = {
          enabled = false;
        };
        VideoSpeed = {
          enabled = false;
          preservePitch = false;
        };
        ViewIcons = {
          enabled = false;
        };
        ViewRaw = {
          clickMethod = "Left";
          enabled = true;
        };
        ViewRawVariant = {
          enabled = false;
        };
        VoiceButtons = {
          enabled = false;
        };
        VoiceChannelLog = {
          enabled = false;
        };
        VoiceChatDoubleClick = {
          enabled = false;
        };
        VoiceChatUtilities = {
          enabled = false;
        };
        VoiceDownload = {
          enabled = false;
        };
        VoiceJoinMessages = {
          enabled = false;
        };
        VoiceMessageTranscriber = {
          enabled = false;
        };
        VoiceMessages = {
          enabled = true;
        };
        VoiceRejoin = {
          applyOnlyToDms = false;
          enabled = true;
          preventReconnectIfCallEnded = "both";
          rejoinDelay = 2;
          rejoinTimeout = 30;
        };
        VolumeBooster = {
          enabled = true;
          multiplier = 2;
        };
        WaitForSlot = {
          enabled = false;
        };
        WallpaperFree = {
          enabled = false;
        };
        WebContextMenus = {
          addBack = false;
          enabled = true;
        };
        WebKeybinds = {
          enabled = true;
        };
        WebRichPresence = {
          enabled = false;
        };
        WebScreenShareFixes = {
          enabled = true;
          experimentalAV1Support = false;
        };
        WebpackTarball = {
          enabled = false;
        };
        WhitelistedEmojis = {
          enabled = false;
        };
        WhoReacted = {
          avatarClick = false;
          enabled = true;
        };
        WhosWatching = {
          enabled = true;
        };
        WigglyText = {
          enabled = true;
          intensity = 4;
        };
        WriteUpperCase = {
          enabled = false;
        };
        XSOverlay = {
          enabled = false;
        };
        YoutubeAdblock = {
          enabled = false;
        };
        YoutubeDescription = {
          enabled = true;
        };
        arRPCBun = {
          enabled = false;
        };
      };
      themeLinks = [ ];
      themeNames = { };
      transparent = false;
      uiElements = {
        chatBarButtons = { };
        messagePopoverButtons = { };
      };
      useQuickCss = false;
      userCssVars = { };
      winCtrlQ = false;
      winNativeTitleBar = false;
    };
  };

  my.persistence.directories = [ ".config/equibop" ];
}
