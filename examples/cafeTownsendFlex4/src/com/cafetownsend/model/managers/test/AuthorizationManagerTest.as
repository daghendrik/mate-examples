package com.cafetownsend.model.managers.test
{
	import com.cafetownsend.model.constants.Authorization;
	import com.cafetownsend.model.managers.AuthorizationManager;
	
	import flash.events.Event;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	
	public class AuthorizationManagerTest
	{		
		protected var manager: AuthorizationManager;
		
		[Before]
		public function setUp():void
		{
			manager = new AuthorizationManager();
		}
		
		[After]
		public function tearDown():void
		{
			manager = null;
		}
		
		
		[Test( description="Change status after login")]
		public function changeStatusOnLogin():void
		{
			manager.login('Flex', 'Mate');
			
			Assert.assertEquals( manager.status, Authorization.LOGGED_IN );
			
		}

	
		
		[Test( description="Changing status after logout")]
		public function statusChangedOnLogout():void
		{	
			
			manager.logout();
			
			Assert.assertEquals( manager.status, Authorization.LOGGED_OUT );
			
		}


		
		//--------------------------------------------------------------------------
		//
		// test bindings
		//
		//--------------------------------------------------------------------------
		
		[Test( async, description="Trigger statusChanged on login")]
		public function triggerStatusChangedOnLogin():void
		{
			Async.proceedOnEvent( this, manager, AuthorizationManager.STATUS_CHANGED, 200, bindingNeverOccurred );
			
			manager.login('Flex', 'Mate');
		
		}
		
		
		[Test( async, description="AsyncTest of changing states after logout")]
		public function triggerStatusChangedOnLogout():void
		{
			Async.proceedOnEvent( this, manager, AuthorizationManager.STATUS_CHANGED, 200, bindingNeverOccurred );

			manager.logout();

		}
		
		protected function bindingNeverOccurred( passThroughData:Object ):void 
		{
			Assert.fail( 'Bindings are not triggered');
		}
		
	}
}