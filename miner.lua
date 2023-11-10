steps = 9
waitTime = 1
digDown_time = 
function piston(side) do
    redstone.setOutput(side, true)
    os.sleep(waitTime)
    redstone.setOutput(side, false)
end

function move(c) do
    print("Moving forward"..c)
    piston("back")
    os.sleep(0.5)
    piston("left")
    os.sleep(waitTime)
end

function dig() do
    print("Start digging")
    redstone.setOutput("front", true)
    os.sleep(300)
    print("Retrieving digger")
    redstone.setOutput("front", false)
    os.sleep(50)
end

while true do 
    for i=1,steps do
        move(i)
    end
    dig()
end

