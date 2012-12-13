window.location.hash = ''
markers = <%=raw(@markers)%>
Gmaps.map.replaceMarkers(markers)
marker = Gmaps.map.markers[0]
infowindow = marker.infowindow
infowindow.open(Gmaps.map.map, marker.serviceObject)
Gmaps.map.map.setZoom(16)
window.location.hash = 'payment_map'