package com.cafetownsend.ui.presenters
{
	import com.cafetownsend.events.LoginEvent;
	import com.cafetownsend.model.constants.Navigation;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	
	public class MainUIPresentationModel extends EventDispatcher
	{
		public static const CURRENTSTATE_CHANGE_EVENT:String = "currentStateChange";
		
		private var _currentState:String = Navigation.LOGIN;

		
		// -------------------------------------------------------
		// Contructor
		// -------------------------------------------------------
		
		private var dispatcher:IEventDispatcher;
		public function MainUIPresentationModel( dispatcher:IEventDispatcher ):void
		{
			this.dispatcher = dispatcher;
		}
		
		
		public function logout() : void 
		{
			var event:LoginEvent = new LoginEvent( LoginEvent.LOGOUT );
			dispatcher.dispatchEvent(event);
		}
		
		
		[Bindable(event="currentStateChange")]
		public function get currentState():String
		{
			return _currentState;
		}

		public function set navigationPath(path:String):void
		{
			//
			// get the first path value only
			var value: String = path.split("/")[0];
				
			if (_currentState != value) {			
				_currentState = value;
				dispatchEvent(new Event(CURRENTSTATE_CHANGE_EVENT));
			}
		}

	}
}