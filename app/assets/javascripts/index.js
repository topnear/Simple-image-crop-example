$(function() {
	var $listAdWrapper = $(".list-ad-wrapper")
	$listAdWrapper.imagesLoaded(function() {
		$listAdWrapper.masonry()
	})
})
