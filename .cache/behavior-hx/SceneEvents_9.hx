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



class SceneEvents_9 extends SceneScript
{
	public var _Score:Float;
	public var _EneDeath:Float;
	public var _PlayerDeath:Float;
	public var _BloodOpacity:Float;
	public var _opacity:Float;
	
	
	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		nameMap.set("Score", "_Score");
		_Score = 0.0;
		nameMap.set("EneDeath", "_EneDeath");
		_EneDeath = 0.0;
		nameMap.set("PlayerDeath", "_PlayerDeath");
		_PlayerDeath = 0.0;
		nameMap.set("BloodOpacity", "_BloodOpacity");
		_BloodOpacity = 0.0;
		nameMap.set("opacity", "_opacity");
		_opacity = 0.0;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		_EneDeath = 22;
		_PlayerDeath = 3;
		Engine.engine.setGameAttribute("PlayerHealth", 5);
		getActor(24).alpha = 0 / 100;
		_BloodOpacity = 0;
		_opacity = 0;
		
		/* =========================== On Actor =========================== */
		addMouseOverActorListener(getActor(25), function(mouseState:Int, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && 3 == mouseState)
			{
				_opacity = 0;
				_BloodOpacity = 0;
				getActor(24).alpha = 0 / 100;
				getActor(25).moveTo(591, 244, 1.5, Easing.expoInOut);
				setVolumeForChannel(150/100, 4);
				playSoundOnChannel(getSound(85), 4);
			}
		});
		
		/* ========================= Type & Type ========================== */
		addSceneCollisionListener(getActorType(83).ID, getActorType(1).ID, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				recycleActor(event.thisActor);
				Engine.engine.setGameAttribute("PlayerHealth", ((Engine.engine.getGameAttribute("PlayerHealth") : Float) - 1));
			}
		});
		
		/* =========================== Keyboard =========================== */
		addKeyStateListener("Hurt Self", function(pressed:Bool, released:Bool, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && pressed)
			{
				Engine.engine.setGameAttribute("PlayerHealth", ((Engine.engine.getGameAttribute("PlayerHealth") : Float) - 1));
				if(((Engine.engine.getGameAttribute("PlayerHealth") : Float) == 4))
				{
					getActor(1).setAnimation("FirstHit");
				}
				else if(((Engine.engine.getGameAttribute("PlayerHealth") : Float) == 3))
				{
					getActor(1).setAnimation("SecondHit");
				}
				else if(((Engine.engine.getGameAttribute("PlayerHealth") : Float) == 2))
				{
					getActor(1).setAnimation("ThirdHit");
				}
				else if(((Engine.engine.getGameAttribute("PlayerHealth") : Float) == 1))
				{
					getActor(1).setAnimation("FourthHit");
				}
				else if(((Engine.engine.getGameAttribute("PlayerHealth") : Float) == 0))
				{
					getActor(1).setAnimation("dead");
				}
			}
		});
		
		/* ========================= When Drawing ========================= */
		addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				g.setFont(getFont(38));
				g.drawString("" + "Score: ", 460, 440);
				g.drawString("" + (Engine.engine.getGameAttribute("Score") : Float), 550, 440);
			}
		});
		
		/* ======================== Actor of Type ========================= */
		addWhenTypeGroupKilledListener(getActorType(5), function(eventActor:Actor, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				_EneDeath = (_EneDeath - 1);
				Engine.engine.setGameAttribute("Score", ((Engine.engine.getGameAttribute("Score") : Float) + 10));
				_BloodOpacity = (_BloodOpacity + 1);
				_opacity = (_opacity + 10);
				getActor(24).alpha = (_opacity + 10) / 100;
			}
		});
		
		/* ======================== Actor of Type ========================= */
		addWhenTypeGroupKilledListener(getActorType(7), function(eventActor:Actor, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				_EneDeath = (_EneDeath - 1);
				Engine.engine.setGameAttribute("Score", ((Engine.engine.getGameAttribute("Score") : Float) + 25));
				_BloodOpacity = (_BloodOpacity + 1);
				_opacity = (_opacity + 10);
				getActor(24).alpha = (_opacity + 10) / 100;
			}
		});
		
		/* ======================== Actor of Type ========================= */
		addWhenTypeGroupKilledListener(getActorType(3), function(eventActor:Actor, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				_EneDeath = (_EneDeath - 1);
				Engine.engine.setGameAttribute("Score", ((Engine.engine.getGameAttribute("Score") : Float) + 15));
				_BloodOpacity = (_BloodOpacity + 1);
				_opacity = (_opacity + 10);
				getActor(24).alpha = (_opacity + 10) / 100;
			}
		});
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if((_EneDeath == 0))
				{
					switchScene(GameModel.get().scenes.get(15).getID(), null, createCrossfadeTransition(0.5));
				}
				if(((Engine.engine.getGameAttribute("PlayerHealth") : Float) == 0))
				{
					switchScene(GameModel.get().scenes.get(9).getID(), null, createCrossfadeTransition(1));
				}
				if((_BloodOpacity == 5))
				{
					getActor(25).moveTo(432, 244, 1.5, Easing.expoInOut);
				}
				if(((Engine.engine.getGameAttribute("PlayerHealth") : Float) == 4))
				{
					getActor(1).setAnimation("FirstHit");
				}
				else if(((Engine.engine.getGameAttribute("PlayerHealth") : Float) == 3))
				{
					getActor(1).setAnimation("SecondHit");
				}
				else if(((Engine.engine.getGameAttribute("PlayerHealth") : Float) == 2))
				{
					getActor(1).setAnimation("ThirdHit");
				}
				else if(((Engine.engine.getGameAttribute("PlayerHealth") : Float) == 1))
				{
					getActor(1).setAnimation("FourthHit");
				}
				else if(((Engine.engine.getGameAttribute("PlayerHealth") : Float) == 0))
				{
					getActor(1).setAnimation("dead");
				}
			}
		});
		
		/* ======================== Specific Actor ======================== */
		addWhenKilledListener(getActor(1), function(list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				_PlayerDeath = (_PlayerDeath - 1);
				if((_PlayerDeath == 2))
				{
					getActor(26).fadeTo(0, 0, Easing.expoInOut);
				}
				if((_PlayerDeath == 1))
				{
					getActor(25).fadeTo(0, 0, Easing.expoInOut);
				}
			}
		});
		
		/* ======================= Every N seconds ======================== */
		runPeriodically(1000 * 2, function(timeTask:TimedTask):Void
		{
			if(wrapper.enabled)
			{
				if(!(_EneDeath == 0))
				{
					Engine.engine.setGameAttribute("Score", ((Engine.engine.getGameAttribute("Score") : Float) - 10));
				}
			}
		}, null);
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}