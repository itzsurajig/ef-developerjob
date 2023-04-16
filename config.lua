Config = Config or {}

Config.ShowBlip = true
 
Config.JobPrice = math.random(350, 450)   

Config.PaymentTax = 5 

Config.Invincible = true 
Config.Frozen = true 
Config.Stoic = true
Config.FadeIn = true 
Config.DistanceSpawn = 20.0 

Config.MinusOne = true 

Config.JobVehicles = {
    [1] = 'rumpo2',
}


Config.Locations = {
    ["job"] = {
        label = "EF-Productions",
        coords = vector4(-1082.17, -247.6, 37.76, 28.42),
    },

    ["vehicle"] = {
        label = "Service Van",
        coords = vector4(-1099.49, -263.56, 37.64, 190.62),
    },
   
    
    ["devwork"] = {
        [1] = {
            name = "Fix Software",
            coords = vector4(378.78, 332.97, 103.57, 309.04),
        },
        [2] = {
            name = "Fix Software",
            coords = vector4(-2361.43, 3250.4, 101.45, 89.25),
        },
        [3] = {
            name = "Fix Software",
            coords = vector4(-3249.82, 1005.01, 12.83, 44.0),
        },
        [4] = {
            name = "Fix Software",
            coords = vector4(-105.65, 6470.63, 31.63, 121.2),
        },
        
    },
    ["devwork2"] = {
        [1] = {
            name = "Fix Software",
            coords = vector4(-1828.19, 797.85, 138.18, 123.95),
        },
        [2] = {
            name = "Fix Software",
            coords = vector4(378.73, 333.08, 103.57, 327.33),
        },
        [3] = {
            name = "Fix Software",
            coords = vector4(153.24, -3211.76, 5.91, 266.95), 
        }, 
        [4] = {
            name = "Fix Software",
            coords = vector4(-1062.81, -248.37, 44.02, 264.97),
        },
    },
    ["devwork3"] = {
        [1] = {
            name = "Fix Software",
            coords = vector4(-806.5, 167.58, 76.74, 185.64),
        },
        [2] = {
            name = "Fix Software",
            coords = vector4(-44.49, -1749.88, 29.42, 32.74),
        },
        [3] = {
            name = "Fix Software",
            coords = vector4(545.77, 2662.87, 42.16, 165.15), 
        }, 
        [4] = {
            name = "Fix Software",
            coords = vector4(1706.23, 4921.51, 42.06, 313.55),
        },
    },
    ["devwork4"] = {
        [1] = {
            name = "Fix Software",
            coords = vector4(1735.3, 6420.43, 35.04, 332.3),
        },
        [2] = {
            name = "Fix Software",
            coords = vector4(-448.87, 6013.02, 31.72, 63.55),
        },
        [3] = {
            name = "Fix Software",
            coords = vector4(-2347.05, 3269.65, 32.81, 255.57), 
        }, 
        
    },
    ["jobset5"] = {
        [1] = {
            name = "Fix Software",
            coords = vector4(-2364.41, 3245.45, 92.9, 98.97),
        },
        [2] = {
            name = "Fix Software",
            coords = vector4(-32.41, -1115.27, 26.42, 55.15),
        },
        
    }
    
}



Config.GenderNumbers = {
	['male'] = 4,
	['female'] = 5
}

Config.PedList = {

	{
		model = `s_m_m_autoshop_01`, 
		coords = vector4(-1083.27, -245.87, 37.76, 213.99), 
		gender = 'male',
        scenario = 'WORLD_HUMAN_CLIPBOARD'
	},

	
}
