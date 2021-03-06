package enchant;

/**
 * ...
 * @author gaya_K
 */

extern class Event
{
    public function new(type:String):Void;

    public var target:EventTarget;
    public var x:Int;
    public var y:Int;
    public var localX:Int;
    public var localY:Int;
    
    public static var LOAD:String;
    public static var PROGRESS:String;
    public static var ENTER_FRAME:String;
    public static var EXIT_FRAME:String;
    public static var ENTER:String;
    public static var EXIT:String;
    public static var CHILD_ADDED:String;
    public static var ADDED:String;
    public static var ADDED_TO_SCENE:String;
    public static var CHILD_REMOVED:String;
    public static var REMOVED:String;
    public static var REMOVED_FROM_SCENE:String;
    public static var TOUCH_START:String;
    public static var TOUCH_MOVE:String;
    public static var TOUCH_END:String;
    public static var RENDER:String;
    public static var INPUT_START:String;
    public static var INPUT_CHANGE:String;
    public static var INPUT_END:String;
    public static var LEFT_BUTTON_DOWN:String;
    public static var LEFT_BUTTON_UP:String;
    public static var RIGHT_BUTTON_DOWN:String;
    public static var RIGHT_BUTTON_UP:String;
    public static var UP_BUTTON_DOWN:String;
    public static var UP_BUTTON_UP:String;
    public static var DOWN_BUTTON_DOWN:String;
    public static var DOWN_BUTTON_UP:String;
    public static var A_BUTTON_DOWN:String;
    public static var A_BUTTON_UP:String;
    public static var B_BUTTON_DOWN:String;
    public static var B_BUTTON_UP:String;
    public static var ADDED_TO_TIMELINE:String;
    public static var REMOVED_FROM_TIMELINE:String;
    public static var ACTION_START:String;
    public static var ACTION_END:String;
    public static var ACTION_TICK:String;
    public static var ACTION_ADDED:String;
    public static var ACTION_REMOVED:String;
}

extern class Core
{
    public function new(width:Float, height:Float):Void;
    
    public static var instance:Core;

    public var width:Float;
    public var height:Float;
    public var scale:Float;
    public var fps:Int;
    public var frame:Int;
    public var ready:Bool;
    public var running:Bool;
    public var assets:Dynamic/*Hash<Surface>*/;
    public var currentScene:Scene;
    public var rootScene:Scene;
    public var loadingScene:Scene;
    public var input:Dynamic/*Hash<Bool>*/;
    public var onload:Void->Void;
    
    public var actualFps(default, null):Int;

    public static function findExt(path:String):String;
    
    public function preload(assets:Array<String>):Void;
    public function load(src:String, callBack:Void->Void):Void;
    public function start():Void;
    public function debug():Void;
    public function getTime():Int;
    public function stop():Void;
    public function pause():Void;
    public function resume():Void;
    public function pushScene(scene:Scene):Scene;
    public function popScene():Scene;
    public function replaceScene(scene:Scene):Scene;
    public function removeScene(scene:Scene):Scene;
    public function keybind(key:Int, button:String):Void;
    public function keyunbind(key:Int):Void;
    public function getElapsedTime():Int;
}

extern class Game extends Core
{
    public function new(width:Float, height:Float):Void;
}

extern class EventTarget
{
    public function new():Void; 

    public function addEventListener(type:String, listener:Event->Void):Void;
    public function removeEventListener(type:String, listener:Event->Void):Void;
    public function clearEventListener(type:String):Void;
    public function dispatchEvent(e:Event):Void;
}

extern class Node extends EventTarget
{
    public function new():Void;
    
    public var age:Int;
    public var parentNode:Group;
    public var scene:Scene;
    
    public var x(default, default):Float;
    public var y(default, default):Float;

    public function moveTo(x:Float , y:Float):Void;
    public function moveBy(x:Float , y:Float):Void;
    public function remove():Void;
}

extern class Entity extends Node
{
    public function new():Void;
    
    public var compositeOperation:Dynamic;  // todo:
    public var buttonMode:String;
    public var buttonPressed:Bool;

    public var width(default, default):Float;
    public var height(default, default):Float;
    public var backgroundColor(default, default):String;
    public var opacity(default, default):Float;
    public var visible(default, default):Bool;
    public var touchEnabled(default, default):Bool;
    public var scaleX(default, default):Float;
    public var scaleY(default, default):Float;
    public var rotation(default, default):Float;
    public var originX(default, default):Float;
    public var originY(default, default):Float;
    
    public function puintersect(other:Entity):Bool;
    public function within(other:Entity, distance:Float):Bool;
    public function scale(x:Float, y:Float):Void;
    public function rotate(deg:Float):Void;
    public function enableCollection():Void;
    public function disableCollection():Void;
    public function getConstructor():Void;
}

extern class Sprite extends Entity
{
    public function new(width:Int, height:Int):Void;
        
    public var image(default, default):Surface;
    public var frame(default, default):Array<Int>;
    
    public function cvsRender(ctx:Dynamic):Void;    // todo:
    public function domRender(element:Dynamic):Void;    // todo:
}

extern class Label extends Entity
{
    public function new(text:String):Void;
    
    public var text:String;
    public var textAlign:String;
    public var font:String;
    public var color:String;
    
    public function cvsRender(ctx:Dynamic):Void;    // todo:
    public function domRender(element:Dynamic):Void;    // todo:
    public function detectRender(ctx:Dynamic):Void;     // todo:
    public function updateBoundArea():Void;
}

extern class Map extends Entity
{
    public function new(tileWidth:Float, tileHeight:Float):Void;
    
    public var collisionData:Array<Array<Int>>;

    public var image(default, default):Surface;
    public var tileWidth(default, default):Float;
    public var tileHeight(default, default):Float;
    
    @:overload(function(data:Array<Array<Array<Int>>>):Void{}) 
    public function loadData(data:Array<Array<Int>>):Void;
    public function checkTile(x:Float, y:Float):Dynamic;    // todo:
    public function hitTest(x:Float, y:Float):Bool;
    public function cvsRender(ctx:Dynamic):Void;    // todo:
    public function domRender(element:Dynamic):Void;    // todo:
}

extern class Group extends Node
{
    public function new():Void;
    
    public var childNodes:Array<Node>;

    public var firstChild(default, null):Node;
    public var lastChild(default, null):Node;
    public var rotation(default, default):Float;
    public var scaleX(default, default):Float;
    public var scaleY(default, default):Float;
    public var originX(default, default):Float;
    public var originY(default, default):Float;

    public function addChild(node:Node):Void;
    public function insertBefore(node:Node, reference:Node):Void;
    public function removeChild(node:Node):Void;
}

extern class Matrix
{
    public function new():Void;
    
    public static var instance:Matrix;
    
    public function reset():Void;
    public function makeTransformMatrix(node:Node, dest:Matrix):Void;
    public function multiply(m1:Matrix, m2:Matrix, dest:Matrix):Void;
    public function multiplyVec(mat:Matrix, vec:Array<Int>, dest:Array<Int>):Void;
}

extern class DetectColorManager
{
    public function new(reso:Int, max:Int):Void;
    
    public var reference:Array<Sprite>;
    public var colorResolution:Int;
    public var max:Int;
    public var capacity:Int;
    
    public function attachDetectColor(sprite:Sprite):Array<Int>;
    public function detachDetectColor(sprite:Sprite):Void;
    public function getSpriteByColor(color:Array<Int>):Sprite;
}

extern class DomManager /*implements IDomMangager*/
{
    @:overload(function(node:Node, elementDefinition:Dynamic/*HTMLElement*/):Void{}) 
    public function new(node:Node, elementDefinition:String):Void;
    
    public var layer:DomLayer;
    public var targetNode:Node;
    public var element:Dynamic/*HTMLElement*/;
    public var style:Dynamic/*CSSStyleDeclaration*/;
    public function getDomElement():Dynamic/*HTMLElement*/;
    public function getDomElementAsNext():Dynamic/*HTMLElement*/;
    public function getNextManager(manager:DomManager):DomManager;
    public function addManager(childManager:DomManager, nextManager:DomManager):Void;
    @:overload(function(childManager:DomlessManager):Void{})
    public function removeManager(childManager:DomManager):Void;
    public function setLayer(layer:DomLayer):Void;
    public function render(inheritMat:Matrix):Void;
    public function domRender():Void;
    public function remove():Void;
}

extern class DomlessManager /*implements IDomMangager*/
{
    public function new(node:Node):Void;
    
    public function getDomElement():Dynamic/*HTMLElement*/;
    public function getDomElementAsNext():Dynamic/*HTMLElement*/;
    public function getNextManager(manager:DomManager):DomManager;
    public function addManager(childManager:DomManager, nextManager:DomManager):Void;
    @:overload(function(childManager:DomlessManager):Void{})
    public function removeManager(childManager:DomManager):Void;
    public function setLayer(layer:DomLayer):Void;
    public function render(inheritMat:Matrix):Void;
    public function remove():Void;    
}

extern class DomLayer extends Group
{
    public function new():Void;
    
    public var width:Int;
    public var height:Int;
}

extern class CanvasLayer extends Group
{
    public function new():Void;
    
    public var width:Int;
    public var height:Int;
    public var context:Dynamic/*CanvasRenderingContext2D*/;
}

extern class Scene extends Group
{
    public function new():Void;
    
    public var width:Int;
    public var height:Int;

    public var backgroundColor(default, default):String;
    
    public function addLayer(type:String, ?i:Int):Void;    // todo:
}

extern class CanvasScene extends Scene
{
    public function new():Void;
}

extern class DOMScene extends Scene
{
    public function new():Void;
}

extern class Surface extends EventTarget
{
    public function new(widht:Float, height:Float):Void;
    
    public var width:Int;
    public var height:Int;
    public var context:Dynamic/*CanvasRenderingContext2D*/;

    public function getPixel(x:Int , y:Int):Array<Int>;
    public function setPixel(x:Int, y:Int, r:Int, g:Int, b:Int, a:Int):Void;
    public function clear():Void;
    public function draw(image:Surface):Void;
    public function clone():Surface;
    public function toDataURL():String;
}

extern class DOMSound extends EventTarget
{
    public function new():Void;
    
    public var furation:Int;
    
    public var currentTime(default, default):Int;
    public var vollume(default, default):Float;
    
    public static function load(src:String, type:String, callBack:Void->Void):Void;
    
    public function play():Void;
    public function pause():Void;
    public function stop():Void;
    public function close():Void;
}

extern class WebAudioSound extends EventTarget
{
    public function new():Void;
    
    public var src:Dynamic;     // todo:
    public var buffer:Dynamic;  // todo:
    public var connectTarget:Dynamic;   // todo:
    
    public var dulation(default, null):Float;
    public var vollume(default, default):Float;
    public var currentTime(default, default):Int;
    
    public static function load(src:String, type:String, callBack:Void->Void):Void;

    public function play(dup:Dynamic):Void; // todo:
    public function pause():Void;
    public function stop():Void;
    public function close():Void;
    
}

extern class ActionEventTarget extends EventTarget
{
    public function new():Void;
}

extern class Timeline extends EventTarget
{
    public function new(node:Node):Void;
    
    public function setFrameBased():Void;
    public function setTimeBased():Void;
    public function next(remainingTime:Float):Void;
    public function tick(enterFrameEvent:EventTarget):Void;
    public function add(action:Action):Timeline;
    public function action(params:String):Timeline; // ??
    public function tween(params:String):Timeline;  // ??
    public function clear():Timeline;
    public function skip(frames:Int):Timeline;
    public function pause():Timeline;
    public function resume():Timeline;
    public function loop():Timeline;
    public function unloop():Timeline;
    public function delay(time:Int):Timeline;
    public function wait(time:Int):Timeline;
    public function then(func:Node->Void):Timeline;
    public function cue(cue:Dynamic/*Dictionary<Int,Void->Void>*/):Void;
    public function repeat(func:Void->Void, time:Int):Timeline;
    public function and():Timeline;
    public function waitUntil(func:Void->Bool):Timeline;
    public function fadeTo(opacity:Float, time:Int , easing:Float->Float->Float->Float->Float):Timeline;
    public function fadeIn(time:Int , easing:Float->Float->Float->Float->Float):Timeline;
    public function fadeOut(time:Int , easing:Float->Float->Float->Float->Float):Timeline;
    public function moveTo(x:Float, y:Float, time:Int , easing:Float->Float->Float->Float->Float):Timeline;
    public function moveX(x:Float, time:Int , easing:Float->Float->Float->Float->Float):Timeline;
    public function moveY(y:Float, time:Int , easing:Float->Float->Float->Float->Float):Timeline;
    public function moveBy(x:Float, y:Float, time:Int , easing:Float->Float->Float->Float->Float):Timeline;
    public function hide():Timeline;
    public function show():Timeline;
    public function removeFromScene():Timeline;
    public function scaleTo(scale:Float , time:Int , easing:Float->Float->Float->Float->Float):Timeline;
    public function scaleBy(scale:Float,time:Int , easing:Float->Float->Float->Float->Float):Timeline;
    public function rotateTo(time:Int , easing:Float->Float->Float->Float->Float):Timeline;
    public function rotateBy(time:Int , easing:Float->Float->Float->Float->Float):Timeline;
}

extern class Action extends EventTarget
{
    public function new(param:Dynamic):Void;    // todo
    
    public var time:Int;
    public var frame:Int;
    public var timeline:Timeline;
    public var node:Node;
}

extern class ParallelAction extends Action
{
    public function new(param:Dynamic):Void;    // todo
    
    public var actions:Dynamic; // todo:
    public var endedActions:Dynamic; // todo:
}

extern class Tween extends Action
{
    public function new(param:Dynamic):Void;    // todo
    
    public var easing:Float->Float->Float->Float->Float;
}

