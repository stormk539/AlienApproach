package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;
import com.stencyl.graphics.ScaleMode;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;
import com.stencyl.models.Joystick;

import com.stencyl.Config;
import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.motion.*;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;
import box2D.collision.shapes.B2Shape;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class SceneEvents_10 extends SceneScript
{
	public var _check:Float;
	
	
	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		nameMap.set("check", "_check");
		_check = 0.0;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		if(((Engine.engine.getGameAttribute("IsPlaying") : Bool) == false))
		{
			loopSoundOnChannel(getSound(56), 2);
			setVolumeForChannel(150/100, 2);
			Engine.engine.setGameAttribute("IsPlaying", true);
		}
		if(((Engine.engine.getGameAttribute("Slide") : Bool) == true))
		{
			getActor(1).moveTo(279, -71, 2, Easing.expoInOut);
			getActor(4).moveTo(279, 57, 4, Easing.expoInOut);
			getActor(2).moveTo(279, 185, 6, Easing.expoInOut);
			getActor(5).growTo(60/100, 60/100, 2, Easing.expoInOut);
			Engine.engine.setGameAttribute("Slide", false);
		}
		else
		{
			getActor(1).moveTo(279, -71, 0, Easing.expoInOut);
			getActor(4).moveTo(279, 57, 0, Easing.expoInOut);
			getActor(2).moveTo(279, 185, 0, Easing.expoInOut);
			getActor(5).growTo(60/100, 60/100, 0, Easing.expoInOut);
		}
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}