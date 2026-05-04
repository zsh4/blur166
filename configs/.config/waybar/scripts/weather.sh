#!/bin/bash
# Pega o clima de forma simplificada
curl -s "wttr.in/?format=1" | sed 's/ //g'
