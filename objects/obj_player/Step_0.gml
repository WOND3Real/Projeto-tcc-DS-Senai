
var _on_wall = place_meeting(x-5,y,obj_cenario) || place_meeting(x+5,y,obj_cenario)

// Movimentação
var _left, _right, _jump 

_left = keyboard_check(ord("A"))
_right = keyboard_check(ord("D"))
_jump = keyboard_check(vk_space) - !keyboard_check_pressed(vk_space)

x_scale = _right - _left
if(_movimento>=5){
	_velh = (_right - _left)*_vel
}

// Colisão
if(place_meeting(x + _velh, y, obj_cenario)){
	while(!place_meeting(x + sign(_velh), y, obj_cenario)){
        x = x + sign(_velh)
    }
	_velh = 0;
}

if (place_meeting(x, y + _velv, obj_cenario)) {
	while(!place_meeting(x, y + sign(_velv), obj_cenario)) {
        y = y + sign(_velv)
    }
	_velv = 0;
}

// gravidade
var _chao = place_meeting(x,y+1,obj_cenario)

if(_chao){
	if(_jump){
		_velv+=_jump_force
	}
}else{
	_velv += _grav
}

//Wall jump

if((_on_wall && (_left || _right)) && !_chao){
	if(_velv > 1){
	_velv = 1
	}
	if(_jump){
		_velv = 0
		_velv += _jump_force
		_velh -= 5*x_scale
		_movimento = 0
		
	}
}

x+=_velh
y+=_velv
