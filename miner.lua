local steps = 9
local waitTime = 1
local piston_immediate = 0.5
local digDownTime = 300
local pullUpTime = 50
local monitor = peripheral.wrap("top")
monitor.setTextScale(0.5)
Line = 1

---Writes a text to the monitor and moves the cursor to the next line
---@param text string
local function write(text)
    monitor.write(text)
    Line = Line + 1
    monitor.setCursorPos(1,Line)
end

---resets the monitor screen and moves the cursor to the first line
local function resetScreen()
    monitor.clear()
    monitor.setCursorPos(1,1)
    Line = 1
end

---waits for the given seconds
---and outputs the remaining time to the monitor
---the output will be below the last output
---and will reset itself after the time is over
---@param time number
local function wait(time)
    while time > 0 do
        monitor.write("Waiting "..time.." seconds")
        os.sleep(math.min(time,10))
        time = time - 10
        monitor.clearLine()
        monitor.setCursorPos(1,Line)
    end
end

---moves piston by providing the given side of the computer
---and turning it on and off with a delay
---which can be tuned by the variable waitTime
---@param side string
local function piston(side)
    redstone.setOutput(side, true)
    os.sleep(waitTime)
    redstone.setOutput(side, false)
    end

---moves the miner contraption forwards
---by the pushing and pulling piston
---also prints out at which step it is given the current step c
---@param c number
local function move(c)
    write("Moving forward "..c)
    piston("back")
    os.sleep(piston_immediate)
    piston("right")
    os.sleep(waitTime)
end

---activates the digging pully and deactivates it once it is finished
---the wait time during and after the digging can be tuned by the variables
---digDownTime and pullUpTime
local function dig()
    write("Start digging")
    redstone.setOutput("left", true)
    wait(digDownTime)
    write("Retrieving digger")
    redstone.setOutput("left", false)
    wait(pullUpTime)
end

---Resets the whole system, meaning it will deactivate all redstone sides
local function reset()
    redstone.setOutput("back", false)
    redstone.setOutput("left", false)
    redstone.setOutput("right", false)
end

-- this is a safe measure to ensure world loadup won't destroy the miner
-- by moving the pulling piston once to potentially pull the pushing piston
piston("right")
-- we enter the infinite loop
while true do
    -- and reset everything to ensure the miner is ready to go
    reset()
    -- if the front is pulled, the mining process is activated
    if redstone.getInput("front") then
        -- we reset the screen
        resetScreen()
        -- and beginn moving the mining platform
        for i=1,steps do
            move(i)
        end
        -- once the mining platform is at the end, we start digging
        dig()
    end
    -- the current mining section is done, so the screen gets reset
    resetScreen()
    -- we write the Programm is halted to the screen
    write("Program halted\n")
    -- sleep for 1 second to prevent lag spikes if the program is halted
    os.sleep(1)
end