USE [master]
GO
/****** Object:  Database [PRJ final]    Script Date: 11/7/2023 3:46:48 PM ******/
CREATE DATABASE [PRJ final]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PRJ final', FILENAME = N'D:\5\SWP\Database\PRJ final.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PRJ final_log', FILENAME = N'D:\5\SWP\Database\PRJ final_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [PRJ final] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PRJ final].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PRJ final] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PRJ final] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PRJ final] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PRJ final] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PRJ final] SET ARITHABORT OFF 
GO
ALTER DATABASE [PRJ final] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PRJ final] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PRJ final] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PRJ final] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PRJ final] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PRJ final] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PRJ final] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PRJ final] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PRJ final] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PRJ final] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PRJ final] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PRJ final] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PRJ final] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PRJ final] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PRJ final] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PRJ final] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PRJ final] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PRJ final] SET RECOVERY FULL 
GO
ALTER DATABASE [PRJ final] SET  MULTI_USER 
GO
ALTER DATABASE [PRJ final] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PRJ final] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PRJ final] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PRJ final] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PRJ final] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PRJ final] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'PRJ final', N'ON'
GO
ALTER DATABASE [PRJ final] SET QUERY_STORE = ON
GO
ALTER DATABASE [PRJ final] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [PRJ final]
GO
/****** Object:  Table [dbo].[books]    Script Date: 11/7/2023 3:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[books](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](255) NULL,
	[description] [nvarchar](max) NULL,
	[image] [nvarchar](255) NULL,
	[author] [nvarchar](100) NULL,
	[genre] [nvarchar](100) NULL,
	[quantity] [int] NULL,
	[available] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Booktype]    Script Date: 11/7/2023 3:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Booktype](
	[booktypeid] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[booktypeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[borrows]    Script Date: 11/7/2023 3:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[borrows](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[book_id] [int] NULL,
	[booktypeid] [int] NOT NULL,
	[startdate] [date] NOT NULL,
	[enddate] [date] NOT NULL,
	[useraddress] [nvarchar](300) NULL,
	[paymentstatus] [varchar](250) NOT NULL,
	[status] [int] NULL,
	[created_at] [datetime] NULL,
	[serviceType] [nvarchar](100) NULL,
	[isFeedback] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[feedbacks]    Script Date: 11/7/2023 3:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[feedbacks](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idUser] [int] NULL,
	[idHk] [int] NULL,
	[message] [nvarchar](max) NULL,
	[star] [int] NULL,
	[createAt] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notifications]    Script Date: 11/7/2023 3:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notifications](
	[NotificationID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Title] [nvarchar](200) NULL,
	[Message] [nvarchar](200) NULL,
	[CreatedAt] [date] NOT NULL,
	[OrderID] [int] NULL,
 CONSTRAINT [PK_Notifications] PRIMARY KEY CLUSTERED 
(
	[NotificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 11/7/2023 3:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[email] [nvarchar](255) NULL,
	[address] [nvarchar](255) NULL,
	[tel] [nvarchar](255) NULL,
	[birthday] [date] NULL,
	[password] [nvarchar](255) NULL,
	[avatar] [nvarchar](255) NULL,
	[verify_key] [nvarchar](255) NULL,
	[is_admin] [bit] NULL,
	[is_verified] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[borrows] ADD  DEFAULT ((0)) FOR [isFeedback]
GO
ALTER TABLE [dbo].[feedbacks] ADD  DEFAULT (getdate()) FOR [createAt]
GO
ALTER TABLE [dbo].[Notifications] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[borrows]  WITH CHECK ADD FOREIGN KEY([book_id])
REFERENCES [dbo].[books] ([id])
GO
ALTER TABLE [dbo].[borrows]  WITH CHECK ADD FOREIGN KEY([booktypeid])
REFERENCES [dbo].[Booktype] ([booktypeid])
GO
ALTER TABLE [dbo].[borrows]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[feedbacks]  WITH CHECK ADD FOREIGN KEY([idHk])
REFERENCES [dbo].[books] ([id])
GO
ALTER TABLE [dbo].[feedbacks]  WITH CHECK ADD FOREIGN KEY([idUser])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD  CONSTRAINT [FK_Notifications_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[Notifications] CHECK CONSTRAINT [FK_Notifications_Users]
GO
/****** Object:  StoredProcedure [dbo].[CheckDuplicates]    Script Date: 11/7/2023 3:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CheckDuplicates] @mail VARCHAR(50),
                                 @tel VARCHAR(50),
                                 @result_code INT OUT
AS
BEGIN
    SET NOCOUNT ON;
        IF EXISTS (SELECT 1 FROM users WHERE email = @mail)
            SET @result_code = 1;
        ELSE
            IF EXISTS (SELECT 1 FROM users WHERE tel = @tel)
                SET @result_code = 2;
            ELSE
                SET @result_code = 0;
END
GO
USE [master]
GO
ALTER DATABASE [PRJ final] SET  READ_WRITE 
GO
