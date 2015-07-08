package com.bridge.ui.controls.grid
{
	import com.addicted2flash.layout.LayoutEventType;
	import com.addicted2flash.layout.core.ILayoutComponent;
	import com.addicted2flash.layout.layouts.Row;
	import com.addicted2flash.layout.layouts.Table;
	import com.addicted2flash.layout.layouts.TableLayout;
	import com.bridge.ui.controls.Canvas;
	import com.bridge.ui.controls.ContentWindow;
	import com.bridge.ui.core.UIComponent;
	import com.bridge.ui.core.ui_internal;
	import com.bridge.ui.skins.simple.SimpleVerticalScrollBarSkin;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public class DataGrid extends Canvas
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        

		private var _table:Table;
		private var _columns:Array;
		private var _tl:TableLayout;
		private var _dataProvider:Object;
		
		
		private static const ROW_HEIGHT:int = 20;
		private static const H_GAP:int		= 1;
		private static const V_GAP:int      = 1;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function DataGrid()
		{
			super();
			
			_columns = new Array();
			
			
			_table 		= new Table(H_GAP,V_GAP);
			this.layout = _tl = new TableLayout(_table);
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function set dataProvider(value:Object):void
		{
			_dataProvider = value;
			
			
			invalidateDataProvider();
		}
		
		/**
		 */
		public function get dataProvider():Object
		{
			return _dataProvider;
		}
	
		/**
		 */
		
		override public function get acceptedLayoutEvents():int
		{
			//class that takes children, and executes only that are visible
			return LayoutEventType.SIZE | LayoutEventType.POSITION;
		}
		
		/**
		 */
		
		private var _ig:Boolean;
		
		override public function processLayoutEvent(type:int,c:ILayoutComponent):void
		{
			if(!this._dataProvider)
				return;
				
				
			var nView:UIComponent = this.nestedView;
			
			var startIndex:int = Math.abs(nView.y)/(ROW_HEIGHT + H_GAP);
			
			
			this.setVisible(startIndex);
			
		}
		
		/**
		 */
		
		public function get columns():Array
		{
			return _columns;
			
		}
		
		/**
		 */
		
		public function set columns(value:Array):void
		{
			_columns = value;
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
       
       	/**
		 */
		 
		public function addColumn(column:DataGridColumnRenderer):void
		{
			_columns.push(column);
		}
		
		/**
		 */
		
		override public function removeAllChildren():void
		{
			for(var i:int = 0; i < _table.rowCount; i++)
			{
				_table.removeRow(_table.getRowAt(0));
				this.removeChildAt(0);
			}
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------

        /**
		 */
		 
		override protected function init():void
		{
			super.init();
			
			
			this.invalidateDataProvider();
			
			//listen for when items are popped off the stage
			this.nestedView.addLayoutObserver(this);
		}
		
		
		/**
		 * must be content window
		 */
		 
		override protected function set content(value:DisplayObjectContainer):void
		{
			super.content = ContentWindow(value);
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		private function invalidateDataProvider():void
		{
			if(!this.initialized || !this._dataProvider)
				return;
				
			var i:int = 0;
			
			var nView:UIComponent = this.nestedView;
			
			
			this.setVisible(0);
			
			
			
		}
		
		
		/**
		 */
		
		private function addRow(index:int):void
		{
			var row:Row = new Row();
			var child:DisplayObject;
			
			for each(var column:DataGridColumnRenderer in _columns)
			{
				if(row)
				{
					row.add(column);
				}
				
				addChild(column.getFieldData(dataProvider[index],index));
			}
			
			row.setHeight(ROW_HEIGHT);
			
			_table.add(row);
			
		}
		
		/**
		 */
		
		private function removeRow(index:int):void
		{
			
			_table.removeRow(_table.getRowAt(index));
		}
		
		/**
		 */
		
		
		private function setVisible(startIndex:int):void
		{
			
			if(_ig)
				return;
				
			_ig = true;
				
			//the number of list items to show
			var showNum:int     = this.ui_internal::content.height / (ROW_HEIGHT + H_GAP);
			
			//the last list item to show
			var lastIndex:int   = startIndex + showNum + 1;
			
			
			var j:int;
			
			if(showNum != this.numChildren)
			{
				fillRows(showNum);
			}
			
			for(var i:int = startIndex; i <= lastIndex; i++)
			{
				
				
				if(!setColumnData(j,i))
					break;
					
				j+=_table.columnCount/_table.rowCount;
			}
			_ig = false;
		}
		
		private function setColumnData(index:int,dataIndex:int):Boolean
		{
			
			var column:DataGridColumn;
			var currentData:Object;
						
			for(var i:int = 0; i < _table.columnCount/_table.rowCount; i++)
			{
				column = this.getChildAt(index+i) as DataGridColumn;
				currentData = _dataProvider[dataIndex];
			
				if(!column || !currentData)
					return false;
					
				column.data = currentData;
			}
			
			return true;
		}
		
		
		/**
		 */
		
		
		private function fillRows(num:int):void
		{
			//if the screen is resized, add or pop off rows
			if(num > _table.rowCount)
			{
				for(var i:int = _table.rowCount; i < num; i++)
				{
					addRow(i);
				}
			}
			else
			//to save processing, remove columns that are invisible
			if(num < _table.rowCount)
			{
				for(var i:int = _table.rowCount; i > num; i--)
				{
					removeRow(_table.rowCount-1);
					removeChildAt(this.numChildren-1);
				}
			}
			
			this.setRowHeight();
		}
		
		/**
		 */
		
		private function setRowHeight():void
		{
			
			if(!this.nestedView || !_dataProvider)
				return;
				
			//alter the preferend size for the *ScrollableContent* so that the scrollBar thinks it's height is larger than it is
			this.nestedView.preferredSize.height = _dataProvider.length() * (ROW_HEIGHT + H_GAP);
			
		}

	}
}