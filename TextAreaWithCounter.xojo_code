#tag Class
Protected Class TextAreaWithCounter
Inherits WebSDKUIControl
	#tag Event
		Sub DrawControlInLayoutEditor(g as graphics)
		  g.DrawingColor = Color.RGB(200, 200, 200)
		  g.DrawRoundRectangle(0, 0, g.Width, g.Height - 38, 10, 10)
		  g.DrawingColor = Color.RGB(0, 0, 0)
		  g.FontSize = 16
		  g.DrawText("0/100", 0, g.Height - 14)
		End Sub
	#tag EndEvent

	#tag Event
		Function ExecuteEvent(name as string, parameters as JSONItem) As Boolean
		  Select Case name
		  Case "LimitExceeded"
		    LimitExceeded
		  End Select
		End Function
	#tag EndEvent

	#tag Event
		Function HandleRequest(Request As WebRequest, Response As WebResponse) As Boolean
		  
		End Function
	#tag EndEvent

	#tag Event
		Function JavaScriptClassName() As String
		  Return "Xojo.TextAreaWithCounter"
		End Function
	#tag EndEvent

	#tag Event
		Sub Serialize(js as JSONItem)
		  js.Value("text") = mText
		  js.Value("textLimit") = mTextLimit
		  js.Value("allowExceedLimit") = mAllowExceedLimit
		End Sub
	#tag EndEvent

	#tag Event
		Function SessionCSSURLs(session as WebSession) As String()
		  If mCSSFile = Nil Then
		    mCSSFile = New WebFile
		    mCSSFile.Data = kCSS
		    mCSSFile.Filename = "TextAreaWithCounter.css"
		    
		    mCSSFile.MIMEType = "text/css"
		    mCSSFile.Session = Nil
		  End If
		  
		  Return Array(mCSSFile.URL)
		End Function
	#tag EndEvent

	#tag Event
		Function SessionHead(session as WebSession) As String
		  
		End Function
	#tag EndEvent

	#tag Event
		Function SessionJavascriptURLs(session as WebSession) As String()
		  If mJSFile = Nil Then
		    'mJSFile = WebFile.Open(SpecialFolder.Resources.Child("js").Child("TextAreaWithCounter.js"))
		    
		    mJSFile = New WebFile
		    mJSFile.Data = kJavaScript
		    mJSFile.Filename = "TextAreaWithCounter.js"
		    
		    mJSFile.MIMEType = "text/javascript"
		    mJSFile.Session = Nil
		  End If
		  
		  Return Array(mJSFile.URL)
		End Function
	#tag EndEvent


	#tag Hook, Flags = &h0
		Event LimitExceeded()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mAllowExceedLimit
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mAllowExceedLimit = value
			End Set
		#tag EndSetter
		AllowExceedLimit As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAllowExceedLimit As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mCSSFile As WebFile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mJSFile As WebFile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mText As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTextLimit As Integer = 100
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mText
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mText = value
			  UpdateControl
			End Set
		#tag EndSetter
		Text As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mTextLimit
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mTextLimit = value
			End Set
		#tag EndSetter
		TextLimit As Integer
	#tag EndComputedProperty


	#tag Constant, Name = kCSS, Type = String, Dynamic = False, Default = \".TextAreaWithCounter {\n    display: flex;\n    flex-direction: column;\n}\n\n.TextAreaWithCounter textarea {\n    height: 100%;\n    resize: none;\n}\n\n.TextAreaWithCounter span {\n    padding: 7px 0;\n}\n\n.TextAreaWithCounter span.limit-exceeded {\n    color: red;\n}", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kJavaScript, Type = String, Dynamic = False, Default = \"\"use strict\";\nvar Xojo;\n(function (Xojo) {\n    class TextAreaWithCounter extends XojoWeb.XojoVisualControl {\n        constructor(id\x2C events) {\n            super(id\x2C events);\n            this.mTextArea \x3D document.createElement(\'textarea\');\n            this.mTextLimit \x3D 100;\n            this.mCountLabel \x3D document.createElement(\'span\');\n            this.mAllowExceedLimit \x3D true;\n            const el \x3D this.DOMElement(\'\');\n            el \x3D\x3D\x3D null || el \x3D\x3D\x3D void 0 \? void 0 : el.append(this.mTextArea\x2C this.mCountLabel);\n            el \x3D\x3D\x3D null || el \x3D\x3D\x3D void 0 \? void 0 : el.classList.add(\'form-group\');\n            this.mTextArea.classList.add(\'form-control\');\n            this.mTextArea.addEventListener(\'input\'\x2C () \x3D> {\n                if (!this.mAllowExceedLimit) {\n                    this.mTextArea.value \x3D this.mTextArea.value.substring(0\x2C this.mTextLimit);\n                }\n                if (this.mTextArea.value.length > this.mTextLimit) {\n                    this.triggerServerEvent(\'LimitExceeded\'\x2C new XojoWeb.JSONItem()\x2C false);\n                }\n                this.updateLabel();\n            });\n        }\n        updateControl(data) {\n            super.updateControl(data);\n            const json \x3D JSON.parse(data);\n            if (typeof json.text !\x3D\x3D \'undefined\') {\n                this.mTextArea.value \x3D json.text;\n            }\n            if (typeof json.textLimit !\x3D\x3D \'undefined\') {\n                this.mTextLimit \x3D json.textLimit;\n            }\n            this.mAllowExceedLimit \x3D json.mAllowExceedLimit;\n            this.refresh();\n        }\n        render() {\n            super.render();\n            const el \x3D this.DOMElement(\'\');\n            if (!el)\n                return;\n            this.setAttributes(el);\n            this.updateLabel();\n            this.applyTooltip(el);\n            this.applyUserStyle(el);\n        }\n        updateLabel() {\n            this.mCountLabel.textContent \x3D `${this.mTextArea.value.length}/${this.mTextLimit}`;\n            this.mCountLabel.classList.toggle(\'limit-exceeded\'\x2C this.mTextArea.value.length > this.mTextLimit);\n        }\n    }\n    Xojo.TextAreaWithCounter \x3D TextAreaWithCounter;\n})(Xojo || (Xojo \x3D {}));\n", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="34"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockHorizontal"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockVertical"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="_mPanelIndex"
			Visible=false
			Group="Behavior"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ControlID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="_mName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Text"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextLimit"
			Visible=true
			Group="Behavior"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowExceedLimit"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Visual Controls"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Visual Controls"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Indicator"
			Visible=true
			Group="Visual Controls"
			InitialValue=""
			Type="WebUIControl.Indicators"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - Primary"
				"2 - Secondary"
				"3 - Success"
				"4 - Danger"
				"5 - Warning"
				"6 - Info"
				"7 - Light"
				"8 - Dark"
				"9 - Link"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
