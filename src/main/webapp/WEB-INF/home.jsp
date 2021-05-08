<%@ taglib prefix="sm" uri="http://jsmartframework.com/v2/jsp/taglib/jsmart" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>JSmart Framework - Async Archetype</title>
    </head>

    <body class="container">

        <!-- Example of asynchronous server event -->

        <div class="col-md-6" style="float: none; margin: auto; margin-top: 50px;">

            <!-- Alert to provide response from WebBean -->
            <sm:alert id="feedback">
                <sm:header title="@{texts.async.archetype.feedback.alert}" />
                <!-- Message will be added via WebContext on HomeBean -->
                <div style="text-align: right;">
                    <sm:button label="I got it!" onClick="$('#feedback').alert('close');" />
                </div>
            </sm:alert>

			<!-- 
				The input below will be updated via function updateClock when async 
				server event is received 
			-->
			<sm:input id="clock-id" label="@{texts.async.archetype.input.label}" 
					leftAddOn="@{texts.async.archetype.addon}" rightAddOn="clock-btn">

				<!-- Button to send -->
				<sm:button id="clock-btn" ajax="true" label="@{texts.async.archetype.button.label}" action="@{homeBean.updateClockTime}">

				    <!--
				        Specifies the value for the first argument of method updateClockTime.
				        You can place as much argument as you but and the order of declaration
				        is important
                    -->
					<sm:arg bindTo="clock-id" />

					<!-- Glyphicon to be placed inside button -->
					<sm:icon name="glyphicon-time" />

					<!-- Animated load will replace the icon during the request -->
					<sm:load />
				</sm:button>
			</sm:input>

            <!--
                Example of asynchronous request using async component to start server sent event
                from AsyncBean mapped on server
            -->
            <sm:async id="clock" path="/home/clock" withCredentials="false">
                <sm:asyncevent event="clock-event" execute="updateClock" />
            </sm:async>
        </div>

        <!-- Callback functions -->
        <script type="text/javascript">
            function updateClock(event) {
                $('#clock-id').val(event.data);
            }
        </script>
    </body>

</html>
