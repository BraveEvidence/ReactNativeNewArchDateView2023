package com.rtnmydateview

import android.app.Activity
import android.app.DatePickerDialog
import android.content.Context
import android.view.View
import android.view.ViewGroup
import com.facebook.react.bridge.ReactContext
import com.facebook.react.uimanager.UIManagerHelper
import com.facebook.react.uimanager.events.EventDispatcher
import java.util.*

class MyDateView(context: Context,currentActivity: Activity): View(context) {
    private var currentDateTime: Calendar = Calendar.getInstance()
    private val mYear = currentDateTime.get(Calendar.YEAR)
    private val mMonth = currentDateTime.get(Calendar.MONTH)
    private val mDay = currentDateTime.get(Calendar.DAY_OF_MONTH)
    var reactContext = getContext() as ReactContext

    init {
        val layoutParams = ViewGroup.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT)
        setLayoutParams(layoutParams)

        val datePickerDialog = DatePickerDialog(currentActivity,
            { view, year, month, day ->
                val monthOfYear = if (month <= 9){
                    "0$month"
                } else {
                    month
                }
                val dayOfMonth = if(day <= 9){
                    "0$day"
                } else {
                    day
                }
                val eventDispatcher: EventDispatcher? =
                    UIManagerHelper.getEventDispatcherForReactTag(
                        reactContext, id
                    )
                eventDispatcher?.dispatchEvent(MyDateViewEvent(id,"$year $monthOfYear $dayOfMonth"))
            }, mYear, mMonth, mDay
        )
        datePickerDialog.show()
    }

}