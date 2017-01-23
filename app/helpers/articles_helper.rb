module ArticlesHelper

	def status_options
		[
			['Draft','Draft'],
			['Published','Published'],
			['Scheduled','Scheduled']
		]
	end

	def visibility_options
		[
			['Private','Private'],
			['Public','Public'],
			['Hidden','Hidden']
		]
	end
end
