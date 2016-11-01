var map, dialog;
require([
        "esri/map", 
        "esri/layers/FeatureLayer",
        "esri/symbols/SimpleFillSymbol", 
        "esri/symbols/SimpleLineSymbol",
        "esri/renderers/SimpleRenderer",
        "esri/graphic", 
        "esri/lang",
        "dojo/_base/Color",
        "dojo/number", 
        "dojo/dom-style",
        "dijit/TooltipDialog",
        "dijit/popup", 
        "dojo/domReady!"
      ], function (
        Map, FeatureLayer,
        SimpleFillSymbol, SimpleLineSymbol,
        SimpleRenderer, Graphic, esriLang,
        Color, number, domStyle,
        TooltipDialog, dijitPopup
      ) {

          var graphic, graphicDot;
          var currLocation;
          map = new Map("mapDiv", {
              basemap: "hybrid",
              center: [-106.837, 40.476],
              zoom: 15,
              slider: false,
              logo: false
          });

          var TrailLayer = new FeatureLayer("http://maps.steamboatsprings.net/arcgis/rest/services/Trails/TrailsHH/MapServer/0", {
              mode: FeatureLayer.MODE_SNAPSHOT,
              outFields: ["name", "LengthMi", "LengthKm"]
          });

          var imageParameters = new esri.layers.ImageParameters();
          imageParameters.format = "jpeg";  //set the image type to PNG24, note default is PNG8.

          var TrailLabels = new esri.layers.ArcGISDynamicMapServiceLayer("http://maps.steamboatsprings.net/arcgis/rest/services/Trails/TrailsHHLabels/MapServer",
          { "opacity": 1, "imageParameters": imageParameters });

          var symbol = new SimpleLineSymbol(
            SimpleLineSymbol.STYLE_SOLID,
            new Color([103, 53, 53]),
            3);

          TrailLayer.setRenderer(new SimpleRenderer(symbol));
          map.addLayer(TrailLabels);
          map.addLayer(TrailLayer);

          map.infoWindow.resize(245, 125);

          dialog = new TooltipDialog({
              id: "tooltipDialog",
              style: "position: absolute; width: 250px; font: normal normal normal 10pt Helvetica;z-index:100"
          });
          dialog.startup();

          var highlightSymbol = new SimpleLineSymbol(SimpleLineSymbol.STYLE_SOLID,
           new Color([217, 43, 43]), 3);

          //close the dialog when the mouse leaves the highlight graphic
          map.on("load", function () {
              initZoom();
              map.graphics.enableMouseEvents();
              // map.graphics.on("mouse-out", closeDialog); ;
          });

          //dojo.connect(map, "OnMouseUp", function () { map.graphics.add(graphicDot); });
          //listen for when the onMouseOver event fires on the countiesGraphicsLayer
          //when fired, create a new graphic with the geometry from the event.graphic and add it to the maps graphics layer
       
          TrailLayer.on("click", function (evt) {
              closeDialog();
              var t = "<b>${name}</b><hr>"
                    + "<b>${LengthMi:NumberFormat} mi</b><br>"
                    + "<b>${LengthKm:NumberFormat} km</b><br>";

              var content = esriLang.substitute(evt.graphic.attributes, t);
              var highlightGraphic = new Graphic(evt.graphic.geometry, highlightSymbol);
              map.graphics.add(highlightGraphic);

              dialog.setContent(content);

              domStyle.set(dialog.domNode, "opacity", 0.85);
              dijitPopup.open({
                  popup: dialog,
                  x: evt.pageX,
                  y: evt.pageY
              });
          });

          function closeDialog() {
              map.graphics.clear();
              dijitPopup.close(dialog);

              if (!graphicDot) { }
              else
                  map.graphics.add(graphicDot);
          }

          function initZoom(map) {
              if (navigator.geolocation) {
                  //   navigator.geolocation.watchPosition(showLocation, locationError);
                  navigator.geolocation.getCurrentPosition(showLocation, locationError);
                  navigator.geolocation.getCurrentPosition(zoomToLocation, locationError);
              }
          }

          function locationError(error) {
              switch (error.code) {
                  case error.PERMISSION_DENIED:
                      alert("Location not provided");
                      break;

                  case error.POSITION_UNAVAILABLE:
                      alert("Current location not available");
                      break;

                  case error.TIMEOUT:
                      alert("Timeout");
                      break;

                  default:
                      alert("unknown error");
                      break;
              }
          }

          function zoomToLocation(location) {
              var pt = esri.geometry.geographicToWebMercator(new esri.geometry.Point(location.coords.longitude, location.coords.latitude));
              var newExtent = new esri.geometry.Extent(pt.x - 500, pt.y - 500, pt.x + 500, pt.y + 500, map.spatialReference);
              map.setExtent(newExtent);
          }

          function showLocation(location) {
              //zoom to the users location and add a graphic
              var pt = esri.geometry.geographicToWebMercator(new esri.geometry.Point(location.coords.longitude, location.coords.latitude));
              if (!graphic) {
                  var symbol = new esri.symbol.PictureMarkerSymbol('Images/BlueDot.png', 20, 20);
                  graphicDot = new esri.Graphic(pt, symbol);
                  map.graphics.add(graphicDot);
              }
              else { //move the graphic if it already exists
                  graphic.setGeometry(pt);
              }
              console.log("Accuracy: " + location.coords.accuracy);
              console.log("Speed: " + location.coords.speed);
              map.centerAt(pt);
              //layer.refresh();
          }

          function orientationChanged() {
              if (map) {
                  map.reposition();
                  map.resize();
              }
          }

      });
     