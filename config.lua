Config = {}

Config.Shops = {
    {
        computer = {
            coords = vector4(1159.18, -315.37, 69.0, 95.0),
            lenght = 0.5,
            width = 0.5,
            label = 'Login',
            icon = 'fas fa-computer',
            code = tostring(math.random(3000,5000)),
            requireditem = 'phone'
        },
        stash = {
            coords = vector4(1159.51, -314.1, 69.21, 105.93),
            lenght = 1,
            width = 1,
            label = 'Unlock',
            icon = 'fas fa-key',
            headerdialog = 'Store Safe',
            inputlabel = 'Enter PIN',
            inputdescription = 'Input the PIN to unlock safe',
            inputicon = 'fas fa-lock',
            placeholder = '6969',
            progresstext = 'Looting Safe',
            reward = math.random(5000,10000)
        }
    }
}