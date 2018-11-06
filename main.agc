
// Project: LevelEditor 
// Created: 2018-10-20

// show all errors
SetErrorMode(2)

// set window properties
SetWindowTitle( "LevelEditor" )
SetWindowSize( 3000, 3000, 0 )
SetWindowAllowResize( 1 ) // allow the user to resize the window

// set display properties
SetVirtualResolution( 3000, 3000 ) // doesn't have to match the window
SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
SetSyncRate( 30, 0 ) // 30fps instead of 60 to save battery
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts

LoadImage(1,"blankTile.png")
LoadImage(2,"1.png")
LoadImage(3,"2.png")
LoadImage(4,"3.png")
blankTexture = CreateSprite(1)

firstTexture = CreateSprite(2)
SecondTexture = CreateSprite(3)
ThirdTexture = CreateSprite(4)


//Help
SetSpritePosition(firstTexture,2200,10)
SetSpriteScale(firstTexture,2,2)
CreateText(1,"=1")
SetTextPosition(1,2350,10)
SetTextSize(1,100)

SetSpritePosition(secondTexture,2200,210)
SetSpriteScale(secondTexture,2,2)
CreateText(2,"=2")
SetTextPosition(2,2350,210)
SetTextSize(2,100)

SetSpritePosition(thirdTexture,2200,410)
SetSpriteScale(thirdTexture,2,2)
CreateText(3,"=3")
SetTextPosition(3,2350,410)
SetTextSize(3,100)

CreateText(4,"Arrow Keys to Move")
SetTextPosition(4,2200,610)
SetTextSize(4,100)
CreateText(7,"'Delete' to Delete")
SetTextPosition(7,2200,810)
SetTextSize(7,100)

CreateText(5,"'S' to save   Remember to open the textfile in notepad++ if you want to view the ACML file as this helps to stop corruption :)")
SetTextPosition(5,2200,1010)
SetTextSize(5,100)
SetTextMaxWidth(5,500)
//Help End


levelData as string[1070]
	
sizex = 32
sizey = 32
spriteCount = 0
currentXCount = 0
currentYCount = 0

do	
	//Spawn in area
    if currentXCount < sizex
		CloneSprite(spriteCount,blankTexture)
		SetSpritePosition(spriteCount,64*currentXCount,64*currentYCount)
		currentXCount=currentXCount+1
		spriteCount = spriteCount+1
		levelData[spriteCount] = "u,"
		
		if currentXCount = sizex and currentYCount < sizey
			currentYCount = currentYCount + 1
			currentXCount = 0
		endif
	endif
	if currentXCount = sizex and currentYCount = sizey
		Sync()
	endif
	
	

		
	//Change colour of each square and update array
	if GetRawKeyState(49) = 1 and GetSpriteHit(GetRawMouseX()+GetViewOffsetX(),GetRawMouseY()+GetViewOffsetY()) <1056
		SetSpriteImage(GetSpriteHit(GetRawMouseX()+GetViewOffsetX(),GetRawMouseY()+GetViewOffsetY()),2)
		levelData[GetSpriteHit(GetRawMouseX()+GetViewOffsetX(),GetRawMouseY()+GetViewOffsetY())] = "1,"
	endif
	if GetRawKeyState(50) = 1 and GetSpriteHit(GetRawMouseX()+GetViewOffsetX(),GetRawMouseY()+GetViewOffsetY()) <1056
		SetSpriteImage(GetSpriteHit(GetRawMouseX()+GetViewOffsetX(),GetRawMouseY()+GetViewOffsetY()),3)
		levelData[GetSpriteHit(GetRawMouseX()+GetViewOffsetX(),GetRawMouseY()+GetViewOffsetY())] = "2,"
	endif	
	if GetRawKeyState(51) = 1 and GetSpriteHit(GetRawMouseX()+GetViewOffsetX(),GetRawMouseY()+GetViewOffsetY()) <1056
		SetSpriteImage(GetSpriteHit(GetRawMouseX()+GetViewOffsetX(),GetRawMouseY()+GetViewOffsetY()),4)
		levelData[GetSpriteHit(GetRawMouseX()+GetViewOffsetX(),GetRawMouseY()+GetViewOffsetY())] = "3,"
	endif
	if GetRawKeyState(46) = 1 and GetSpriteHit(GetRawMouseX()+GetViewOffsetX(),GetRawMouseY()+GetViewOffsetY()) <1056
		SetSpriteImage(GetSpriteHit(GetRawMouseX()+GetViewOffsetX(),GetRawMouseY()+GetViewOffsetY()),1)
		levelData[GetSpriteHit(GetRawMouseX()+GetViewOffsetX(),GetRawMouseY()+GetViewOffsetY())] = "u,"
	endif


	//Save array to file
	if GetRawKeyReleased(83)
		DeleteFile("levelFile.ACML")
		i=0
		OpenToWrite(1,"levelFile.ACML",0)
		while i < spriteCount
			WriteString(1,levelData[i])
			i = i+1
		endwhile
		CloseFile(1)
	endif
	
	
	
	if GetRawKeyState(38) = 1 
		SetViewOffset(GetViewOffsetX(),GetViewOffsetY()-20)
	endif
	if GetRawKeyState(40) = 1
		SetViewOffset(GetViewOffsetX(),GetViewOffsetY()+20)
	endif
	if GetRawKeyState(37) = 1
		SetViewOffset(GetViewOffsetX()-20,GetViewOffsetY())
	endif
	if GetRawKeyState(39) = 1
		SetViewOffset(GetViewOffsetX()+20,GetViewOffsetY())
	endif
    

    //Print( ScreenFPS() )

loop

