# KAutoSlider
İOS Automatic Switching Slider

![alt tag](https://user-images.githubusercontent.com/16580898/30991872-a372bdee-a4af-11e7-94f7-cd25bc9dc1e1.png)

#### Use

```Swift
    autoSlider = KAutoSlider(to: self)
    autoSlider.images = [#imageLiteral(resourceName: "l1"),#imageLiteral(resourceName: "l2"),#imageLiteral(resourceName: "l3")]
    autoSlider.animationType = .alpha // .alpha,translation,scale
    autoSlider.start()
```

##### Stop & Remove

```Swift
    autoSlider.stop()
    autoSlider.remove()
```

## License
Usage is provided under the [MIT License](http://http//opensource.org/licenses/mit-license.php). See LICENSE for the full details.
