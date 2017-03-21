import UIKit
import PlaygroundSupport
/*:
## Newton's Cradle and UIKit Dynamics
This playground uses **UIKit Dynamics** to create a [Newton's Cradle](https://en.wikipedia.org/wiki/Newton%27s_cradle). Commonly seen on desks around the world, Newton's Cradle is a device that illustrates conservation of momentum and energy.
 
Let's create an instance of our UIKit Dynamics based Newton's Cradle. Try adding more colors to the array to increase the number of balls in the device.
*/
let newtonsCradle = NewtonsCradle(colors: [#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1),#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)])
/*:
### Size and spacing
Try changing the size and spacing of the balls and see how that changes the device. What happens if you make `ballPadding` a negative number?
*/
newtonsCradle.ballSize = CGSize(width: 60, height: 60)
newtonsCradle.ballPadding = 2.0
/*:
### Behavior
Adjust `elasticity` and `resistance` to change how the balls react to eachother.
*/
newtonsCradle.itemBehavior.elasticity = 1.0
newtonsCradle.itemBehavior.resistance = 0.2
/*:
### Shape and rotation
How does Newton's Cradle look if we use squares instead of circles and allow them to rotate?
*/
newtonsCradle.useSquaresInsteadOfBalls = false
newtonsCradle.itemBehavior.allowsRotation = false
/*:
### Gravity
Change the `angle` and/or `magnitude` of gravity to see what Newton's Device might look like in another world.
*/
newtonsCradle.gravityBehavior.angle = CGFloat(M_PI_2)
newtonsCradle.gravityBehavior.magnitude = 1.0
/*:
### Attachment
What happens if you change `length` of the attachment behaviors to different values?
*/
for attachmentBehavior in newtonsCradle.attachmentBehaviors {
    attachmentBehavior.length = 100
}

PlaygroundPage.current.liveView = newtonsCradle
