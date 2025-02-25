scene = {
}

import "scenes/gameplay"
import "scenes/main_menu"
import "scenes/more"
import "scenes/stats"

function scene.update()
	scene.current.update()
end

function scene.switchTo(targetScene)
	if targetScene == nil then
		print("ERROR: nil scene attempted to be switched to")
		return
	end

	if scene.current and scene.current.denit then
		scene.current.denit()
	end

	scene.current = targetScene

	if scene.current.init then
		scene.current.init()
	end
end
