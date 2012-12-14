window.location.hash = ''
markers = <%=raw(@markers)%>
Gmaps.map.replaceMarkers(markers)
window.location.hash = 'payment_map'