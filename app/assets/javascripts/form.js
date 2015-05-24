$(function(){
	function setCoords(c) {
		$("#crop-x").val(Math.floor(c.x))
		$("#crop-y").val(Math.floor(c.y))
	}

	function toCrop() {
		
		$("#crop-image").Jcrop({
			boxHeight: 400,
			onChange: setCoords,
			onSelect: setCoords,
			allowResize: false,
			allowSelect: false,
			setSelect:   [ 0, 0, 800, 400 ]
		},showCropBox)
	}

	function showCropBox() {
		$.fancybox.toggle()
		$("#crop-box").css({
			display: "block"
		})
	}

	function setFancyBox(html_data) {
		Options = {
			beforeShow: toCrop,
			scrolling: false,
			closeBtn: true
		}
		$.fancybox.open(html_data, Options)
	}

	$newAdvertisement = $("#new-advertisement")

	$("#alert-client button").on("click", function() {
		$("#alert-client").removeClass("show-error")
	})

	$("#image-uploader").fileupload({
		url: "/pictures",
		maxFileSize: 1000000,
		acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
		submit: function(e,data) {
			data.formData = {"advertisement[picture_key]": $("#picture-key").val()}
		},
		send: function(e,data) {
			$newAdvertisement.addClass("is-loading")
		},
		processfail: function(e,date) {
			$("#alert-client > .error-text").text(date.files[0].error)
			$("#alert-client").addClass("show-error")
		},
		done: function(e, data) {
			$newAdvertisement.removeClass("is-loading")
			$.ajax({
				type: "POST",
				dataType: 'html',
				url: data.result[0]["url"],
				cache: false,
				success: setFancyBox
			})
		},
		fail: function(e,data) {
			$newAdvertisement.removeClass("is-loading")
			$("#alert-client > .error-text").text(data.jqXHR.responseJSON[0]["geometry_error"])
			$("#alert-client").addClass("show-error")
		}
	})
})