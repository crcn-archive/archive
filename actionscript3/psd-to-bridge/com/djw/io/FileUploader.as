
package com.djw.io {
	import com.djw.events.io.*;
	
	import flash.display.MovieClip;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	public class FileUploader extends MovieClip {
		
		public var phpUploadScript:String = "http://www.yoururl.com/upload.php";
		public var uploadDir:String = "";
		public var uploadURL:URLRequest;
		public var fileFilters:Array;
		public var fileName:String;

		public var progress_txt:TextField;
		public var bg_mc:MovieClip;
		
		private var _fileRef:FileReference = new FileReference();
		
		public function FileUploader(uploadScript:String,uploadDir:String = "",...filters:Array) {
			this.uploadDir = uploadDir;
			phpUploadScript = uploadScript;
			this.fileFilters = filters;
			this.uploadURL = new URLRequest(this.phpUploadScript + "?uploadDir=" + this.uploadDir);
			
			this.browse();
			
			//event handlers
			this._fileRef.addEventListener(Event.SELECT, this.selectFile);
			this._fileRef.addEventListener(Event.OPEN, this.openFile);
			this._fileRef.addEventListener(HTTPStatusEvent.HTTP_STATUS, this.httpStatus);
			this._fileRef.addEventListener(Event.COMPLETE, this.completeUpload);
			this._fileRef.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityError);
			this._fileRef.addEventListener(IOErrorEvent.IO_ERROR, this.ioError);
			this._fileRef.addEventListener(Event.CANCEL, this.cancel);
			this._fileRef.addEventListener(ProgressEvent.PROGRESS, this.uploadProgress);
			this._fileRef.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, this.uploadComplete);
			
			
			//make the whole thing draggable for fun
			this.buttonMode = true;
			this.useHandCursor = true;
			this.addEventListener(MouseEvent.MOUSE_DOWN, this.startDragger);
			this.addEventListener(MouseEvent.MOUSE_UP, this.stopDragger);
			
			//stop
			this.stop();
			
		}
		
		public function browse():void {
			this._fileRef.browse(this.fileFilters);
		}
		
		private function selectFile(e:Event):void {
			trace(" [FileUploader] File Selected");
			
			//upload the file
			fileName = this._fileRef.name;
			
			this._fileRef.upload(this.uploadURL);
		}
		
		private function openFile(e:Event):void {
			trace(" [FileUploader] File Upload Started");
		}
		
		private function completeUpload(e:Event):void {
			trace(" [FileUploader] File Upload Complete");
		}
		
		private function httpStatus(e:HTTPStatusEvent) {
			trace(" [FileUploader] HTTP Status: " + e.status);
			this.dispatchEvent(new UploadFailedEvent());
		}
		
		private function securityError(e:SecurityErrorEvent) {
			trace(" [FileUploader] Security Error: " + e.text);
			this.dispatchEvent(new UploadFailedEvent());
		}
		
		private function ioError(e:IOErrorEvent) {
			trace(" [FileUploader] IOError: " + e.text);
			this.dispatchEvent(new UploadFailedEvent());
		}
		
		private function cancel(e:Event):void {
			this.close();
		}
		
		private function close(...args:Array):void {
			//this.parent.removeChild(this);
			//delete this; //mark for gc
		}
		
		private function uploadProgress(e:ProgressEvent):void {
			//trace(" [FileUploader] progress: " + e.bytesLoaded + " / " + e.bytesTotal);
			//this.progress_txt.text = Math.round((e.bytesLoaded / e.bytesTotal) * 100) + "%";
		}
		
		private function uploadComplete(e:DataEvent):void {
			trace(" [FileUploader] File Upload DATA Complete");
			//show the user its done
			this.gotoAndStop(2);
			
			//add a listener to kill it when they click
			this.addEventListener(MouseEvent.CLICK, this.close);
			
			this.dispatchEvent(new UploadCompleteEvent());
		}
		
		private function startDragger(e:MouseEvent):void {
			this.startDrag(false);
		}
		
		private function stopDragger(e:MouseEvent):void {
			this.stopDrag();
		}
		
	}
	
}
