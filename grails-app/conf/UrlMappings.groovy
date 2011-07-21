class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		"/"(controller: "campsite", action:"overview")
		"500"(view:'/error')
	}
}
