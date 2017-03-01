//: Playground - noun: a place where people can play

import UIKit

// 构造器
/*
 
 构造过程是使用类、结构体或枚举类型一个实例的准备过程。
 在新实例可用前必须执行这个过程,具体操作包括设置实例中每个存储型属性的初始值和执行其他必须的设置或初始化工作。
 
 通过定义构造器( Initializers )来实现构造过程,这些构造器可以看做是用来创建特定类型新实例的特殊方法。
 与 Objective-C 中的构造器不同,Swift 的构造器无需返回值,它们的主要任务是保证新实例在第一次使用前完成正确的初始化。
 
 类的实例也可以通过定义析构器( deinitializer )在实例释放之前执行特定的清除工作。
 */




// 1. 存储属性的初始赋值

/*
 ***** 类和结构体在创建实例时,必须为所有存储型属性设置合适的初始值。存储型属性的值不能处于一个未知的状态。
 
 你可以在构造器中为存储型属性赋初值,也可以在定义属性时为其设置默认值。
 
 ***** 当你为存储型属性设置默认值或者在构造器中为其赋值时,它们的值是被直接设置的,不会触发任何属性观察者( property observers )。
 
 */



// 1.1 构造器

/*
 构造器在创建某特定类型的新实例时调用。它的最简形式类似于一个不带任何参数的实例方法,以关键字 init 命名。
 
 init() {
    // 在此处执行构造过程
 }
 
 */


struct Fahrenheit {
    var temperature: Double // 也可在此给存储属性提供默认值
    init() { // 不带参数的构造器
        temperature = 32.0 // 在构造器中初始化存储属性
    }
}
var f = Fahrenheit() // 生成一个实例
print("The default temperature is \(f.temperature)° Fahrenheit")



// 1.2 默认属性值

/*
 如果一个属性总是使用相同的初始值,那么为其设置一个默认值比每次都在构造器中赋值要好。
 两种方法的效果是一样的,只不过使用默认值让属性的初始化和声明结合的更紧密。
 使用默认值能让你的构造器更简洁、更清晰,且能通过默认值自动推导出属性的类型;同时,它也能让你充分利用默认构造器、构造器继承等特性(后续章节将讲到)。
 */

// 使用更简单的方式在定义结构体 Fahrenheit 时为属性 temperature 设置默认值:
struct FahrenheitStruct {
    var temperature = 32.0
}






// 2. 自定义构造过程

/*
 可以通过输入参数和可选属性类型来自定义构造过程,也可以在构造过程中修改常量属性。 (之后会讲)
 */


// 2.1 构造参数
/*
 自定义构造过程时,可以在定义中提供构造参数,指定所需值的类型和名字。
 构造参数的功能和语法跟函数和方法的参数相同。
 */

struct Celsius {
    var temperatureInCelsius: Double
    // 有一个参数的构造器，fromFahrenheit 外部参数名，fahrenheit 内部参数名
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    // 有一个参数的构造器，fromKelvin 外部参数名，kelvin 内部参数名
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    } }
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0) //boilingPointOfWater.temperatureInCelsius 是 100.0
let freezingPointOfWater = Celsius(fromKelvin: 273.15) // freezingPointOfWater.temperatureInCelsius 是 0.0”


// 2.2 参数的内部名称和外部名称

/*
 跟函数和方法参数相同,构造参数也存在一个在构造器内部使用的参数名字和一个在调用构造器时使用的外部参数名字。
 
 然而,构造器并不像函数和方法那样在括号前有一个可辨别的名字。
 所以在调用构造器时,主要通过构造器中的参数名和类型来确定需要调用的构造器。
 正因为参数如此重要,如果你在定义构造器时没有提供参数的外部名字,Swift 会为每个构造器的参数自动生成一个跟内部名字相同的外部名,就相当于在每个构造参数之前加了一个哈希符号。
 
 
 ******* 如果不通过外部参数名字传值,你是没法调用这个构造器的。
        只要构造器定义了某个外部参数名,你就必须使用它,忽略它将导致编译错误。
 */


struct Color {
    let red, green, blue: Double
    
    // 外部参数名 和 内部参数名 相同
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)



// 2.3 不带外部名的构造器参数

/*
 如果你不希望为构造器的某个参数提供外部名字,你可以使用下划线(_)来显示描述它的外部名
 */

struct Celsius_ {
    var temperatureInCelsius: Double = 0.0
    
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    
    // 忽略外部参数名的构造器
    init(_ celsius: Double){
        temperatureInCelsius = celsius
    }
}

let bodyTemperature = Celsius_(37.0) // bodyTemperature.temperatureInCelsius 为 37.0



// 2.4 可选属性类型

/*
 如果你定制的类型包含一个逻辑上允许取值为空的存储型属性 —— 不管是因为它无法在初始化时赋值,还是因为它可以在之后某个时间点可以赋值为空——你都需要将它定义为可选类型 optional type 。可选类型的属性将自动初始化为空 nil ,表示这个属性是故意在初始化时设置为空的。
 */

class SurveyQuestion {
    var text: String
    var response: String? // 可选类型的属性，初始化值为：nil
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    } }
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()// 输出 "Do you like cheese?"
cheeseQuestion.response = "Yes, I do like cheese."



// 2.5 构造过程中常量属性的修改

/*
 可以在构造过程中的任意时间点修改常量属性的值,只要在构造过程结束时是一个确定的值。
 一旦常量属性被赋值,它将永远不可更改。
 
 **** 对于类的实例来说,它的常量属性只能在定义它的类的构造过程中修改;不能在子类中修改。
 
 */
class SurveyQuestionLet {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestionLet(text: "How about beets?")
beetsQuestion.ask()// 输出 "How about beets?"
beetsQuestion.response = "I also like beets. (But not with cheese.)"






// 3. 默认构造器

/*
 如果结构体和类的所有属性都有默认值,同时没有自定义的构造器,那么 Swift 会给这些结构体和类创建一个默认构造器。
 这个默认构造器将简单的创建一个所有属性值都设置为默认值的实例。
 */


class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()
/*
 由于 ShoppingListItem 类中的所有属性都有默认值,且它是没有父类的基类,它将自动获得一个可以为所有属性设置默认值的默认构造器(尽管代码中没有显式为 name 属性设置默认值,但由于 name 是可选字符串类型,它将默认设置为 nil)。上面例子中使用默认构造器创造了一个 ShoppingListItem 类的实例(使用 ShoppingListItem() 形式的构造器语法),并将其赋值给变量 item。
 */



// 3.1 结构体的逐一成员构造器

/*
 除上面提到的默认构造器,如果结构体对所有存储型属性提供了默认值且自身没有提供定制的构造器,它们能自动获得一个逐一成员构造器。
 
 
 逐一成员构造器是用来初始化结构体新实例里成员属性的快捷方法。
 我们在调用逐一成员构造器时,通过与成员属性名相同的参数名进行传值来完成对成员属性的初始赋值。

 */

struct SizeMemberwise {
    var width = 0.0, height = 0.0
}
let twoByTwo = SizeMemberwise(width: 2.0, height: 2.0)








// 4. 值类型的构造器代理

/*
 构造器可以通过调用其它构造器来完成实例的部分构造过程。
 这一过程称为构造器代理,它能减少多个构造器间的代码重复。
 
 
 构造器代理的实现规则和形式在值类型和类中有所不同。
 值类型(结构体和枚举类型)不支持继承,所以构造器代理的过程相对简单,因为它们只能代理给本身提供的其它构造器。
 类则不同,它可以继承自其它类(请参考继承),这意味着类有责任保证其所有继承的存储型属性在构造时也能正确的初始化。
 
 
 对于值类型,你可以使用 self.init 在自定义的构造器中引用其它的属于相同值类型的构造器。
 并且你只能在构造器内部调用 self.init 。
 
 
 如果你为某个值类型定义了一个定制的构造器,你将无法访问到默认构造器(如果是结构体,则无法访问逐一对象构造器)。
 这个限制可以防止你在为值类型定义了一个更复杂的,完成了重要准备构造器之后,别人还是错误的使用了那个自动生成的构造器。
 
 *** 假如你想通过默认构造器、逐一对象构造器以及你自己定制的构造器为值类型创建实例,建议将自己定制的构造器写到扩展( extension )中,而不是跟值类型定义混在一起。想查看更多内容,请查看扩展章节。

 */

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    
    /*
    // origin 和 size 都为默认值0 的构造器
    init() {}
    
    // 指定 origin 和 size 的构造器
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    
    // 指定 center 和 size 的构造器
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
    */
}

// 会保留 默认构造器 和 逐一成员构造器
extension Rect {
    // 指定 center 和 size 的构造器
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}


let basicRect = Rect() // basicRect 的原点是 (0.0, 0.0),尺寸是 (0.0, 0.0)


// originRect 的原点是 (2.0, 2.0),尺寸是 (5.0, 5.0)
let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))


// centerRect 的原点是 (2.5, 2.5),尺寸是 (3.0, 3.0)
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))






// 5. 类的继承和构造过程

/*
 类里面的所有存储型属性--包括所有继承自父类的属性--都必须在构造过程中设置初始值。
 Swift 提供了两种类型的类构造器来确保所有类实例中存储型属性都能获得初始值,它们分别是指定构造器和便利构造器。
 */


// 5.1 指定构造器和便利构造器

/*
 指定构造器是类中最主要的构造器。
 一个指定构造器将初始化类中提供的所有属性,并根据父类链往上调用父类的构造器来实现父类的初始化。
 每一个类都必须拥有至少一个指定构造器。
 
 在某些情况下,许多类通过继承了父类中的指定构造器而满足了这个条件。具体内容请参考后续章节自动构造器的继承。
 
 便利构造器是类中比较次要的、辅助型的构造器。
 你可以定义便利构造器来调用同一个类中的指定构造器,并为其参数提供默认值。
 你也可以定义便利构造器来创建一个特殊用途或特定输入的实例。
 你应当只在必要的时候为类提供便利构造器,比方说某种情况下通过使用便利构造器来快捷调用某个指定构造器,能够节省更多开发时间并让类的构造过程更清晰明了。
 
 
 指定构造器语法：
 init(parameters) {
    statements
 }
 
 
 便利构造器的语法：
 在 init 关键字之前放置 convenience 关键字
 
 convenience init(parameters) {
    statements
 }
 */



// 5.2 类的构造器代理规则

/*
 
 规则 1 指定构造器必须调用其直接父类的的指定构造器。
 规则 2 便利构造器必须调用同一类中定义的其它构造器。
 规则 3 便利构造器必须最终以调用一个指定构造器结束。
 
 也就是说：
 • 指定构造器必须总是向上代理 
 • 便利构造器必须总是横向代理
 

  Superclass      Designated <---- Convenience <---- Convenience
                      ⬆︎
                      ⬆︎<---------------⬆︎
                      ⬆︎                ⬆︎
  Subclass        Designated       Designated <---- Convenience
 
 */





// 5.3 两段式构造过程

/*
 Swift 中类的构造过程包含两个阶段。
 第一个阶段,每个存储型属性通过引入它们的类的构造器来设置初始值。
 当每一个存储型属性值被确定后,第二阶段开始,它给每个类一次机会在新实例准备使用之前进一步定制它们的存储型属性。
 
 
 两段式构造过程的使用让构造过程更安全,同时在整个类层级结构中给予了每个类完全的灵活性。
 两段式构造过程可以防止属性值在初始化之前被访问;也可以防止属性被另外一个构造器意外地赋予不同的值。
 
 
 Swift的两段式构造过程跟 Objective-C 中的构造过程类似。
 最主要的区别在于阶段 1,Objective-C 给每一个属性赋值 0 或空值(比如说 0 或 nil )。
 Swift 的构造流程则更加灵活,它允许你设置定制的初始值,并自如应对某些属性不能以 0 或 nil 作为合法默认值的情况。
 
 
 
 Swift 编译器将执行 4 种有效的安全检查,以确保两段式构造过程能顺利完成:
 
 安全检查 1 
 指定构造器必须保证它所在类引入的所有属性都必须先初始化完成,之后才能将其它构造任务向上代理给父类中的构造器。
 如上所述,一个对象的内存只有在其所有存储型属性确定之后才能完全初始化。
 为了满足这一规则,指定构造器必须保证它所在类引入的属性在它往上代理之前先完成初始化。
 
 安全检查 2 
 指定构造器必须先向上代理调用父类构造器,然后再为继承的属性设置新值。
 如果没这么做,指定构造器赋予的新值将被父类中的构造器所覆盖。
 
 安全检查 3 
 便利构造器必须先代理调用同一类中的其它构造器,然后再为任意属性赋新值。
 如果没这么做,便利构造器赋予的新值将被同一类中其它指定构造器所覆盖。
 
 安全检查 4
 构造器在第一阶段构造完成之前,不能调用任何实例方法、不能读取任何实例属性的值, self 的值不能被引用。
 
 

 
 
 两段式构造过程中基于上述安全检查的构造流程展示:
 
 阶段 1
 • 某个指定构造器或便利构造器被调用;
 • 完成新实例内存的分配,但此时内存还没有被初始化;
 • 指定构造器确保其所在类引入的所有存储型属性都已赋初值。存储型属性所属的内存完成初始化;
 • 指定构造器将调用父类的构造器,完成父类属性的初始化;
 • 这个调用父类构造器的过程沿着构造器链一直往上执行,直到到达构造器链的最顶部;
 • 当到达了构造器链最顶部,且已确保所有实例包含的存储型属性都已经赋值,这个实例的内存被认为已经完 全初始化。此时阶段1完成。
 
 阶段 2
 • 从顶部构造器链一直往下,每个构造器链中类的指定构造器都有机会进一步定制实例。构造器此时可以访问 self 、修改它的属性并调用实例方法等等。
 • 最终,任意构造器链中的便利构造器可以有机会定制实例和使用 self 。

 
 
 */





// 5.4 构造器的继承和重写

/*
 跟 Objective-C 中的子类不同,Swift 中的子类不会默认继承父类的构造器。
 Swift 的这种机制可以防止一个父类的简单构造器被一个更专业的子类继承,并被错误的用来创建子类的实例。
 
 **** 父类的构造器仅在确定和安全的情况下被继承。
 
 
 假如你希望自定义的子类中能实现一个或多个跟父类相同的构造器,也许是为了完成一些定制的构造过程,你可以在你定制的子类中提供和重写与父类相同的构造器。
 
 当你写一个父类中带有指定构造器的子类构造器时,你需要重写这个指定的构造器。
 因此,你必须在定义子类构造器时带上 override 修饰符。
 即使你重写系统提供的默认构造器也需要带上 override 修饰符
 
 
 无论是重写属性,方法或者是下标脚本,只要含有 override 修饰符就会去检查父类是否有相匹配的重写指定构造器和验证重写构造器参数。
 
 */

class Vehicle {
    // 自动生成一个默认构造器
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")


class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")




// 5.5 自动构造器的继承

/*
 
 类不会默认继承父类的构造器。
 但是如果特定条件可以满足,父类构造器是可以被自动继承的。
 在实践中,这意味着对于许多常见场景你不必重写父类的构造器,并且在尽可能安全的情况下以最小的代价来继承父类的构造器。
 
 
 要为子类中引入的任意新属性提供默认值,请遵守以下2个规则:
 
 规则 1 
 如果子类没有定义任何指定构造器,它将自动继承所有父类的指定构造器。

 规则 2 
 如果子类提供了所有父类指定构造器的实现--不管是通过规则1继承过来的,还是通过自定义实现的--它将自动继承所有父类的便利构造器。
 
 
 即使你在子类中添加了更多的便利构造器,这两条规则仍然适用。
 
 */




// 5.6 指定构造器和便利构造器实例

class Food {
    var name: String

    // 指定构造器
    init(name: String) {
        self.name = name
    }
    
    // 便利构造器
    convenience init() {
        self.init(name: "[Unnamed]")
    }
    
    
}

let namedMeat = Food(name: "Bacon")
namedMeat.name

let mysteryMeat = Food() // 默认便利构造器
mysteryMeat.name




class RecipeIngredient: Food {
    var quantity: Int
    
    // 指定构造器
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    // 便利构造器, 实现了父类的所有指定构造器，所以会继承父类的所有便利构造器
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }

    
    func printProperties() {
        print("name = \(name), quantity = \(quantity)")
    }
}

let oneMysteryItem = RecipeIngredient()
oneMysteryItem.printProperties()

let oneBacon = RecipeIngredient(name: "Bacon")
oneBacon.printProperties()

let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)
sixEggs.printProperties()



class ShoppingListItem1: RecipeIngredient {
    
    // 自动继承父类的所有指定构造器和便利构造器
    
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ?" : " ?"
        return output
    }
}


var breakfastList = [
    ShoppingListItem1(),
    ShoppingListItem1(name: "Bacon"),
    ShoppingListItem1(name: "Eggs", quantity: 6),
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}








// 6. 可失败构造器

/*
 如果一个类、结构体或枚举类型的对象,在构造自身的过程中有可能失败,则为其定义一个可失败构造器,是非常有用的。
 这里所指的“失败”是指,如给构造器传入无效的参数值,或缺少某种所需的外部资源,又或是不满足某种必要的条件等。
 
 为了妥善处理这种构造过程中可能会失败的情况。
 你可以在一个类,结构体或是枚举类型的定义中,添加一个或多个可失败构造器。其语法为在 init 关键字后面加添问号 (init?) 。
 
 
 **** 可失败构造器的参数名和参数类型,不能与任何一个非可失败构造器的参数名,及其类型相同。
 
 
 可失败构造器,在构建对象的过程中,创建一个其自身类型为可选类型的对象。
 通过 return nil 语句,来表明可失败构造器在何种情况下“失败”。

 
 
 **** 严格来说,构造器都不支持返回值。
      因为构造器本身的作用,只是为了能确保对象自身能被正确构建。
      所以即使你在表明可失败构造器,失败的这种情况下,用到了 return nil 。
      也不要在表明可失败构造器成功的这种情况下,使用关键字 return 。

 */


struct Animal {
    let species: String
    
    // 可失败构造器
    init?(species: String) {
        if species.isEmpty { return nil } // 传入参数 species 为空时，返回 nil，实例初始化失败
        self.species = species
        // 构造成功，返回实例， 但此时不会明确的使用 return self 语句
    }
}

let someCreature = Animal(species: "Giraffe") // someCreature 的类型是 Animal?(可选类型) 而不是 Animal
if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}


let anonymousCreature = Animal(species: "") // 参数为空，实例初始化失败
if anonymousCreature == nil {
    print("The anonymous creature could not be initialized")
}






// 6.1 枚举类型的可失败构造器

/*
 你可以通过构造一个带一个或多个参数的可失败构造器来获取枚举类型中特定的枚举成员。
 还能在参数不满足枚举成员期望的条件时,构造失败
 
 */

enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}


let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}





// 6.2 带原始值的枚举类型的可失败构造器

/*
 带原始值的枚举类型会自带一个可失败构造器 init?(rawValue:) ,该可失败构造器有一个名为 rawValue 的默认参数,其类型和枚举类型的原始值类型一致,如果该参数的值能够和枚举类型成员所带的原始值匹配,则该构造器构造一个带此原始值的枚举成员,否则构造失败。
 
 */
enum TUnit : String {
    case K, C, F
}

let one = TUnit(rawValue: "F")
if one != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknown = TUnit(rawValue: "X")
if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}





// 6.3 类的可失败构造器

/*
 值类型(如结构体或枚举类型)的可失败构造器,对何时何地触发构造失败这个行为没有任何的限制。
 比如在前面的例子中,结构体 Animal 的可失败构造器触发失败的行为,甚至发生在 species 属性的值被初始化以前。
 
 
 而对类而言,就没有那么幸运了。
 类的可失败构造器只能在所有的类属性被初始化后和所有类之间的构造器之间的代理调用发生完后触发失败行为。
 */

class Product {
    
    let name: String! // 没有初始值，的 隐式解析可选字符串类型 的常量
    
    init?(name: String) {
        self.name = name // 先初始化属性
        
        // name 是一个隐式解析可选字符串类型常量，也就是必须有一个初始值，一旦初始化失败，在使用时就会crash
        if name.isEmpty { return nil }
    }
}

if let bowTie = Product(name: "bow tie") {
    // 不需要检查 bowTie.name == nil， 实例初始化成功，其name必有值
    print("The product's name is \(bowTie.name)")
}






// 6.4 构造失败的传递

/*
 可失败构造器允许在同一类,结构体和枚举中横向代理其他的可失败构造器。
 类似的,子类的可失败构造器也能向上代理基类的可失败构造器。
 
 无论是向上代理还是横向代理,如果你代理的可失败构造器,在构造过程中触发了构造失败的行为,整个构造过程都将被立即终止,接下来任何的构造代码都将不会被执行。
 
 可失败构造器也可以代理调用其它的非可失败构造器。通过这个方法,你可以为已有的构造过程加入构造失败的条件。

 */


class CartItem: Product {
    
    let quantity: Int!
    
    init?(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name) // 向上代理可失败构造器
        if quantity < 1 { return nil }
    }
}

if let twoSocks = CartItem(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}


if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("Unable to initialize zero shirts")
}



if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
    print("Unable to initialize one unnamed product")
}




// 6.5 重写一个可失败构造器

/*
 就如同其它构造器一样,你也可以用子类的可失败构造器重写基类的可失败构造器。
 或者你也可以用子类的非可失败构造器重写一个基类的可失败构造器。
 这样做的好处是,即使基类的构造器为可失败构造器,但当子类的构造器在构造过程不可能失败时,我们也可以把它修改过来。
 
 
 ****当你用一个子类的非可失败构造器重写了一个父类的可失败构造器时,子类的构造器将不再能向上代理父类的可失败构造器。
     一个非可失败的构造器永远也不能代理调用一个可失败构造器。
 
 ***** 你可以用一个非可失败构造器重写一个可失败构造器,但反过来却行不通。
 
 */

class Document {
    var name: String?
    // 该构造器构建了一个name属性值为nil的document对象
    init() {}
    // 该构造器构建了一个name属性值为非空字符串的document对象
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}


class AutomaticallyNamedDocument: Document {
    
    // 重写了父类的两个指定构造器,确保不论是通过没有 name 参数的构造器,还是通过传一个空字符串给 init(name:) 构造器,生成的实例中的 name 属性总有初始值 "[Untitled]" 。
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}



// 可以在构造器中调用父类的可失败构造器强制解包,以实现子类的非可失败构造器。

class UntitledDocument: Document {
    
    override init() {
        // 总有值为 "[Untitled]" 的 name 属性
        super.init(name: "[Untitled]")!
    }
}




// 6.6 可失败构造器 init!

/*
 通常来说我们通过在 init 关键字后添加问号的方式( init? )来定义一个可失败构造器,但你也可以使用通过在 init 后面添加惊叹号的方式来定义一个可失败构造器 (init!) ,该可失败构造器将会构建一个特定类型的隐式解析可选类型的对象。
 
 你可以在 init? 构造器中代理调用 init! 构造器,反之亦然。
 你也可以用 init? 重写 init! ,反之亦然。 
 你还可以用 init 代理调用 init! ,但这会触发一个断言: init! 构造器是否会触发构造失败?
 */











// 8. 必要构造器

// 在类的构造器前添加 required 修饰符表明所有该类的子类都必须实现该构造器:
class SomeClass {
    required init() {
        // 在这里添加该必要构造器的实现代码 
    }
}

// 在子类重写父类的必要构造器时,必须在子类的构造器前也添加 required 修饰符,这是为了保证继承链上子类的构造器也是必要构造器。
// 在重写父类的必要构造器时,不需要添加 override 修饰符:
    class SomeSubclass: SomeClass {
        required init() {
            // 在这里添加子类必要构造器的实现代码 
        }
}

// **** 如果子类继承的构造器能满足必要构造器的需求,则你无需显示的在子类中提供必要构造器的实现。





// 9. 通过闭包和函数来设置属性的默认值

/*
 如果某个存储型属性的默认值需要特别的定制或准备,你就可以使用闭包或全局函数来为其属性提供定制的默认值。
 每当某个属性所属的新类型实例创建时,对应的闭包或函数会被调用,而它们的返回值会当做默认值赋值给这个属性。
 
 这种类型的闭包或函数一般会创建一个跟属性类型相同的临时变量,然后修改它的值以满足预期的初始状态,最后将这个临时变量的值作为属性的默认值进行返回。

 */

/*
class SomeClass {
 
    // 在这个闭包中给 someProperty 创建一个默认值
    // someValue 必须和 SomeType 类型相同
 
    let someProperty: SomeType = {
        return someValue
    }()   // 注意闭包结尾的大括号后面接了一对空的小括号。
          // 这是用来告诉 Swift 需要立刻执行此闭包。
          // 如果你忽略了这对括号,相当于是将闭包本身作为值赋值给了属性,而不是将闭包的返回值赋值给属性。
 
}
*/


// 如果你使用闭包来初始化属性的值,请记住在闭包执行时,实例的其它部分都还没有初始化。这意味着你不能够在闭包里访问其它的属性,就算这个属性有默认值也不允许。同样,你也不能使用隐式的 self 属性,或者调用其它的实例方法。


let count = 8
struct Checkerboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...count {
            for j in 1...count {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
        return boardColors[(row * count) + column]
    }
}

let board = Checkerboard()
print(board.squareIsBlackAtRow(row: 0, column: 1)) // 输出 "true"
print(board.squareIsBlackAtRow(row: 7, column: 7)) // 输出 "false"
































