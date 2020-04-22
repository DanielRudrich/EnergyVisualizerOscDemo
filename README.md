# EnergyVisualizerOscDemo
Visualization of EnergyVisualizer's RMS data with processing

The **Energy**Visualizer from the [IEM Plug-in Suite](https://plugins.iem.at) sends out RMS values of 426 sample points via OSC: [EnergyVisualizerGrid Documentation](https://plugins.iem.at/docs/energyvisualizergrid/)

This little [Processing](https://processing.org) sketch receives the data (port 9001) and visualizes it.

Currently there are three different visualizations, you can change them by a simple mouse click.

As you see, I am not the most talented Processing guy, but I am sure there are people out there who can create incredible things with it. So feel free to use the provided data and make something incredible! :-) Should be fairly simple to add simple image or even a video and use the data to create an overlay.

The data comprises:
- a little bit over 426 vertices
- 920 triangles with info about the surface area
- a rmsIdx array, mapping the vertices to the incoming RMS array


Have fun!

### Dependencies
- **oscP5**: Necessary, to receive OSC data. 
To install: open Processing, Sketch -> Import Library... -> Add Library... install oscP5
