/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import React from 'react';
import type {PropsWithChildren} from 'react';
import {
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  useColorScheme,
  useWindowDimensions,
  View,
} from 'react-native';

import {
  Colors,
  DebugInstructions,
  Header,
  LearnMoreLinks,
  ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';
import RTNMyDateView from 'rtn-my-date-view/js/RTNMyDateViewNativeComponent';

function App(): JSX.Element {
  const isDarkMode = useColorScheme() === 'dark';

  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };

  const {width} = useWindowDimensions();

  return (
    <SafeAreaView style={backgroundStyle}>
      <StatusBar
        barStyle={isDarkMode ? 'light-content' : 'dark-content'}
        backgroundColor={backgroundStyle.backgroundColor}
      />

      <RTNMyDateView
        style={{
          height: 200,
          width,
          margin: 20,
        }}
        onDatePicked={(value: any) => {
          console.log(value.nativeEvent.value);
        }}
      />
    </SafeAreaView>
  );
}

export default App;

//yarn add ./RTNMyDateView

//node rnappdate/node_modules/react-native/scripts/generate-codegen-artifacts.js \
// --path rnappdate/ \
// --outputPath rnappdate/RTNMyDateView/generated/
