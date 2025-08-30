workspace "Self-Healing Infrastructure" "A system for the automated remediation of issues within an IT Infrastructure Environment" {

	!identifiers hierarchical

	model {
		u = person "SRE"
		sha = softwareSystem "Self-Healing Architecture" {
			eda = container "Event-Driven Ansible"
			ai = container "AI Agent"
			llm = container "LLM"
			aap = container "Ansible Controller" {
				mcp = component "MCP Server"
			}
			pac = container "Policy Gate"
			ass = container "Ansible Code Assistant"
		}
		tel = softwareSystem "Telemetry Lake" {
			teldb = container "Telemetry Storage" {
				tags "Database"
				mcp = component "MCP Server"
			}
		}
		inf = softwareSystem "Enterprise Infrastructure"
		adev = softwareSystem "Automation Development Pipeline" {
			blogplay = container "SRE Playbook Backlog"
			blogrule = container "SRE Rulebook Backlog"
		}

		u -> sha.ai "Queries"
		u -> adev.blogplay "Reviews, tests, develops and deploys"
		u -> adev.blogrule "Reviews, tests, develops and deploys"
		inf -> tel.teldb "Sends Observability Data"
		tel -> sha.eda "Sends Events"
		sha.eda -> sha.aap "Rulebooks detect known events to trigger known automations"
		sha.eda -> sha.ai "Sends unknown events"
		sha.ai -> sha.llm "Sends natural language queries"
		sha.llm -> sha.ai "Sends natural language responses"
		sha.ai -> tel.teldb.mcp "Makes MCP queries"
		sha.ai -> sha.aap "Makes MCP queries"
		sha.ai -> sha.aap "Triggers existing automation for unknown events"
		sha.ai -> sha.ass "Triggers generate of new playbooks to remediate unknown events"
		sha.ass -> adev.blogplay "Adds potential remediation to SRE backlog"
		sha.ai -> adev.blogrule "Adds potential remediation to SRE backlog"
		sha.aap -> sha.pac "Checks automation policy"
		sha.pac -> inf "Executes automation"
	}

	views {
		systemContext sha "Infrastructure_Context" {
			include *
			autolayout lr
		}

		container sha "Self-Healing_Architecture" {
			include *
			autolayout lr
		}

		container adev "Automation_Development" {
			include *
			autolayout lr
		}

		container tel "Telemetry_Lake" {
		    include *
		    autolayout lr
		}

		styles {
			element "Element" {
				color #af0707
				stroke #af0707
				strokeWidth 7
				shape roundedbox
			}

			element "Person" {
				shape person
			}

			element "Database" {
				shape cylinder
			}

			element "Boundary" {
				strokeWidth 5
			}

			relationship "Relationship" {
				thickness 4
			}
		}
	}
}