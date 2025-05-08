import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"


export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    showExactLocation: Boolean
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/light-v10"

    })

    this.map.addControl(new mapboxgl.FullscreenControl())
    this.#addRadiusToMap()

    if (this.showExactLocationValue) {
      this.#addMarkersToMap()
      this.#fitMapToMarkers()
    } else {
      this.#fitMapToRadius()
    }

    this.#addRecenterButton()
  }

  #addMarkersToMap() {
    this.markersValue.forEach(marker => {
      new mapboxgl.Marker().setLngLat([marker.lng, marker.lat]).addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([marker.lng, marker.lat]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

  #addRadiusToMap() {
    const marker = this.markersValue[0]
    if (!marker) return

    this.map.on("load", () => {
      this.map.addSource("tool-radius", {
        type: "geojson",
        data: {
          type: "Feature",
          geometry: {
            type: "Point",
            coordinates: [marker.lng, marker.lat]
          }
        }
      })

      this.map.addLayer({
        id: "circle-layer",
        type: "circle",
        source: "tool-radius",
        paint: {
          "circle-radius": {
            stops: [[0, 0], [20, 35000 / 2]],
            base: 2
          },
          "circle-color": "#1e90ff",
          "circle-opacity": 0.1,
          "circle-stroke-color": "#1e90ff",
          "circle-stroke-width": 1
        }
      })
    })
  }

  #fitMapToRadius() {
    const marker = this.markersValue[0]
    if (marker) {
      this.map.setCenter([marker.lng, marker.lat])
      this.map.setZoom(12)
    }
  }

  #addRecenterButton() {
    const btn = document.createElement("button")
    btn.textContent = "Recenter"
    btn.style.cssText = `
      position: absolute;
      top: 10px;
      left: 10px;
      z-index: 1;
      background-color: white;
      padding: 6px 12px;
      border-radius: 999px;
      font-weight: bold;
      box-shadow: 0 2px 6px rgba(0,0,0,0.1);
      cursor: pointer;
      font-size: 14px;
    `
    btn.addEventListener("click", () => {
      const marker = this.markersValue[0]
      this.map.flyTo({ center: [marker.lng, marker.lat], zoom: 12 })
    })
    this.element.appendChild(btn)
  }
}


// map
